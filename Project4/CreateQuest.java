//package project4;


import java.util.*;
import java.net.*;
import java.text.*;
import java.lang.*;
import java.io.*;
import java.sql.*;
import java.sql.Date;

import pgpass.*;



public class CreateQuest {
    
	private Connection conDB;        // Connection to the database system.
    private String url;              // URL: Which database?
    private String user = "yao21"; // Database user account

    private String theme;
    private String realm;
    private String day;
    private String seed;
    private String amount;
    
    private String insertIntoQuestQuery =
    "INSERT INTO quest (theme, realm, day, succeeded) VALUES (?, ?, ?, NULL);";
   
    private String insertIntoLootQuery = 
    "INSERT INTO loot (loot_id, treasure, theme, realm, day) VALUES (?, ?, ?, ?, ?);";
    
  //After Connection - Cursor and handler
  	String queryText = "";
  	PreparedStatement querySt = null;
  	ResultSet answers = null;

    // Constructor
    public CreateQuest (String[] args) {
        // Set up the DB connection.
        try {
            // Register the driver with DriverManager.
            Class.forName("org.postgresql.Driver").newInstance();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.exit(0);
        } catch (InstantiationException e) {
            e.printStackTrace();
            System.exit(0);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            System.exit(0);
        }

        
        if(args.length >= 5) {
        	user = args[4];
        }
      
        
        // URL: Which database?
        //url = "jdbc:postgresql://db:5432/<dbname>?currentSchema=yrb";
        url = "jdbc:postgresql://db:5432/";

        // set up acct info
        // fetch the PASSWD from <.pgpass>
        Properties props = new Properties();
        try {
            String passwd = PgPass.get("db", "*", user, user);
            props.setProperty("user",    user);
            props.setProperty("password", passwd);
            // props.setProperty("ssl","true"); // NOT SUPPORTED on DB
        } catch(PgPassException e) {
            System.out.print("\nCould not obtain PASSWD from <.pgpass>.\n");
            System.out.println(e.toString());
            System.exit(0);
        }

        // Initialize the connection.
        try {
            // Connect with a fall-thru id & password
            //conDB = DriverManager.getConnection(url,"<username>","<password>");
            conDB = DriverManager.getConnection(url, props.getProperty("user"), props.getProperty("password"));
        } catch(SQLException e) {
            System.out.print("\nSQL: database connection error.\n");
            System.out.println(e.toString());
            System.exit(0);
        }    

        // Let's have autocommit turned off.  No particular reason here.
        try {
            conDB.setAutoCommit(false);
        } catch(SQLException e) {
            System.out.print("\nFailed trying to turn autocommit off.\n");
            e.printStackTrace();
            System.exit(0);
        }    

      //Check if correct usage is inputed
        if (checkUsage(args)) {
        	throw new IllegalArgumentException("Usage: CreateQuest <day> <realm> <theme> <amount> [<user>] [seed]");
        }
      
        
        if(allMandatory(args)) {
        	day = args[0];
        	realm = args[1];
        	theme = args[2];
        	amount = args[3];
        	
        	//check user inputs
        	checkDate(day);
        	realmExists(realm);
        	checkAmount(amount);
        	
        	querySt = null;
        	
        	
        	if(args.length == 6) {
        		setSeed(Float.parseFloat(args[5]));
        	}
        	
        	
        	insertIntoQuest();
        	
        	insertIntoLoot();
        	try {
        		conDB.commit();
        		conDB.close();
        	}
        	catch(SQLException e) {
        		System.out.println("Error committing");
        		catchPrint(e);
        	}
        	
        }

    }

    
    
    public void closeConnections() {
    	try {
    		querySt.close();
        	conDB.close();
        	answers.close();
    	}
    	catch(SQLException e) {
    		System.out.println("Closing connection error");
    		catchPrint(e);
    	}
    }
    
    public void insertIntoQuest() {
    	try {
    		Date tempDay = java.sql.Date.valueOf(day);
    		querySt = conDB.prepareStatement(insertIntoQuestQuery);
    		querySt.setString(1, theme);
			querySt.setString(2, realm);
			querySt.setDate(3, tempDay);
			querySt.executeUpdate();
			querySt.close();
    	}
    	catch(SQLException e) {
    		System.out.println("INSERT QUEST failed: ");
			catchPrint(e);
    	}
    }
    
    public void insertIntoLoot() {
    	//Get each row from treasure and iterate through. 
    	//each iteration get name of treasure added to insert statement,
    	//add sql of that treasure to sum
    	
    	try {
    		int sum = 0;
    		int lootID = 1;
    		answers = null;
    		queryText = "SELECT * from treasure order by random();";
    		querySt = conDB.prepareStatement(queryText);
    		answers = querySt.executeQuery();
    		String treasureTobeInputted;
    		int sqlTobeInputted;
    		
    		while(sum < Integer.parseInt(amount)) {
    			if(answers.next()) {
    				treasureTobeInputted = answers.getString("treasure");
    				sqlTobeInputted = answers.getInt("sql");
    				
    				querySt = conDB.prepareStatement(insertIntoLootQuery);
    				querySt.setInt(1, lootID++);
    				querySt.setString(2, treasureTobeInputted);
    				querySt.setString(3, theme);
    				querySt.setString(4, realm);
    				Date tempDay = java.sql.Date.valueOf(day);
    				querySt.setDate(5, tempDay);
    				querySt.executeUpdate();
    				querySt.close();
    				sum += sqlTobeInputted;
    			
    				
    			}
    		}
    	}
    	catch (SQLException e){
    		System.out.println("INSERT LOOT failed: ");
			catchPrint(e);
    	}
    }
    
    
    public void setSeed(float s) {
    	try {
    		queryText = "SELECT setseed(?);";
	    	querySt = conDB.prepareStatement(queryText);
	    	querySt.setFloat(1, s);
	    	answers = querySt.executeQuery();
	    	querySt.close();
	    	answers.close();
    	}
    	catch (SQLException e) {
    		
    		System.out.print("Failed setting seed");
    		catchPrint(e);
    	}
    }
    
    
    
    public void catchPrint(SQLException e) {
    	System.out.println(e.toString());
		System.exit(0);
    }
    
    
    
    
    public void checkDate(String s) {
    	try {
    		Date d = java.sql.Date.valueOf(day);
    		java.sql.Date TodayDate = new java.sql.Date(new java.util.Date().getTime());
    		if(!d.after(TodayDate)) {
    			throw new IllegalArgumentException("day is not in future:");
    		}
    		
    	}
    	catch (Exception e) {
    		System.out.println("Wrong date format");
    	}
    }
   
    //check if amount is proper
    public void checkAmount(String s) {
    	queryText = "SELECT sum(sql) FROM TREASURE;";
    	querySt = null;
    	answers = null;
    	
    	try {
			querySt = conDB.prepareStatement(queryText);
			answers = querySt.executeQuery();
			
			if (answers.next()) {
				int total = answers.getInt(1);
				int amount = Integer.parseInt(s);
				
				if(amount > total) {
					throw new IllegalArgumentException("amount exceeds what is possible:");
				}
			}
		} catch (SQLException e) {
			System.out.println("AMOUNT SQL failed: ");
			System.out.println(e.toString());
			System.exit(0);
		}
    }
    
    
    //check if realm exists in database
    public  void realmExists(String s) {
    	queryText = "SELECT * FROM realm where realm = ?;";
    	querySt = null;
    	answers = null;
    	try {
    		querySt = conDB.prepareStatement(queryText);
    		querySt.setString(1, s);
			answers = querySt.executeQuery();
			if(!answers.next()) {
				throw new IllegalArgumentException("realm does not exist");
			}
    	}
    	catch(SQLException e) {
    		System.out.println("REALM SQL failed: ");
			System.out.println(e.toString());
			System.exit(0);
    	}
    }
    
    public void checkSeed(String s) {
    	try {
    		float tmpSeed = Float.parseFloat(s);
    		if(tmpSeed > 1 || tmpSeed < -1) {
    			throw new IllegalArgumentException("seed value is improper:");
    		}
    	}
    	catch(Exception e) {
    		throw new IllegalArgumentException("Improper seed entered");
    	}
    }
   
    
    
    
    public boolean allMandatory(String args[]) {
    	return args.length >= 4;
    }
    
   public boolean checkUsage (String args[]) {
	   return args.length > 6 || args.length < 4;
   }

    
    
    
    
    
    
   

    public static void main(String[] args) {
        CreateQuest ct = new CreateQuest(args);
    }
 }
