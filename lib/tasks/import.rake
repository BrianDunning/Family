namespace :import do

      desc "import all"
      task :all => :environment do

        Rake::Task["import:familynames"].execute
        #Rake::Task["import:update_users"].execute
        #Rake::Task["import:branches"].execute
        #Rake::Task["import:areas"].execute
        
        #Rake::Task["import:r_and_r"].execute
        #Rake::Task["import:setup_motds"].execute
        #Rake::Task["import:settings"].execute
        #Rake::Task["import:products"].execute
      end


      desc "Imports FAMILYNAMES from a set CSV file & location"
      task :familynames => :environment do
        
        $import = 1
        # RAILS_DEFAULT_LOGGER.error("import = #{@import}")
        
        require File.dirname(__FILE__) + '/../../config/environment'
        require 'CSV' #- leave this out or it will break production env
  
        puts "Importing Family Names"
        if false #RAILS_ENV == "development"
          location = './lib/tasks/import/FamilyNames25.csv'
        else
          location = './lib/tasks/import/FamilyNames.csv'
        end
          
        CSV.foreach( location, :col_sep => "|", :headers => true) do |row|
      
        Familyname.create!(   :id => row[0],
                        :sex => row[1],
                        :firstname => row[2],
                        :middlenames => row[3],
                        :lastname => row[4],
                        :notes => row[5])
        end
        
        
        $import = nil
        # RAILS_DEFAULT_LOGGER.error("import end= #{$import}")
  
      end


      desc "imports BRANCHES from a set CSV file & location"
      task :branches => :environment do
  
        require File.dirname(__FILE__) + '/../../config/environment'
        #require 'FasterCSV' - leave this out or it will break production env

        puts "Importing branches"

        FasterCSV.foreach('./lib/tasks/import/BranchesPiped.csv', :col_sep => "|", :headers => true) do |row|
          Branch.create!(  :setter_id => row[0], 
                                :zone_id => row[1],
                                :area_id => row [2], 
                                :name => row[3], 
                                :year_started => row[4])
        end
    
      end


      desc "imports AREAS from a set CSV file & location"
      task :areas => :environment do
  
        puts "Importing areas"
  
        require File.dirname(__FILE__) + '/../../config/environment'
        #require 'FasterCSV' - leave this out or it will break production env

        FasterCSV.foreach('./lib/tasks/import/AreasPiped.csv', :col_sep => "|", :headers => true) do |row|
      
      
            Area.create!(  :zone_id => row[0],
                                  :name => row [1], 
                                  :coordinator_id => row[2], 
                                  :aux_coordinator_id => row[3])
        end
      end
      
      
      task :cross_check => :environment do
        @users = User.all
        
        branch_ids = Array.new
        for branch in Branch.all
          branch_ids << branch.id
        end
        
        
        for user in @users
          if !branch_ids.include?(user.branch_id)
            raise "BANG #{user.inspect}"
          end
        end
        
      end
      
      
      
      
      desc "imports blitz"
      task :blitz => :environment do
      
        
        blitz = Convention.new({
          :name => "London Scripture Blitz",
          :description => "This is the Scripture Blitz in London laying a foundation for visitors in 2012.",
          :location => "London", 
          :address =>  "<p>Premier Inn,<br/>London Docklands (Excel),<br/>Excel East,<br/>Royal Victoria Dock,<br/>London,<br/>E16 1SL</p>", 
          :main_start_date => "2011-09-21 09:00:00", 
          :main_start_meal => 1, 
          :main_end_date => "2011-09-25 17:00:00", 
          :main_end_meal => 2, 
          :early_start_date => "2011-09-21 09:00:00", 
          :early_start_meal => 1, 
          :late_end_date => "2011-09-25 17:00:00", 
          :late_end_meal => 2, 
          :early_booking_fee_resident_adult => 20.0, 
          :early_booking_fee_resident_child => 0.0, 
          :early_booking_fee_visitor_adult => 20.0, 
          :early_booking_fee_visitor_child => 0.0, 
          :normal_booking_fee_resident_adult => 25.0, 
          :normal_booking_fee_resident_child => 0.0, 
          :normal_booking_fee_visitor_adult => 25.0, 
          :normal_booking_fee_visitor_child => 0.0, 
          :late_booking_fee_resident_adult => 0.0, 
          :late_booking_fee_resident_child => 0.0, 
          :late_booking_fee_visitor_adult => 0.0, 
          :late_booking_fee_visitor_child => 0.0, 
          :attendance_fee_resident_adult => 0.0, 
          :attendance_fee_resident_child => 0.0, 
          :attendance_fee_visitor_adult => 0.0, 
          :attendance_fee_visitor_child => 0.0, 
          :default_breakfast_cost_adult => 0.0, 
          :default_lunch_cost_adult => 25.0, 
          :default_dinner_cost_adult => 20.0, 
          :default_breakfast_cost_child => 0.0, 
          :default_lunch_cost_child => 0.0, 
          :default_dinner_cost_child => 0.0, 
          :children_allowed => false, 
          :free_child_meals_allowed => false, 
          :guests_allowed => false, 
          :spouse_allowed => true, 
          :residents_allowed => true, 
          :visitors_allowed => true, 
          :meals => true, 
          :assignments => true, 
          :distributions => true, 
          :extras => true, 
          :reg_from => "2011-03-20 14:18:00", 
          :early_reg_till => "2011-05-08 23:59:00", 
          :normal_reg_till => "2011-07-31 23:59:00", 
          :reg_till => "2011-07-31 23:59:00", 
          :hotel_booking_url => "", 
          :img1_file_name => nil, 
          :img1_content_type => nil, 
          :img1_file_size => nil, 
          :img1_updated_at => "2011-03-21 14:33:49", 
          :file1_file_name => nil, 
          :file1_content_type => nil, 
          :file1_file_size => nil, 
          :file1_updated_at => nil, 
          :ical_file => nil, 
          :created_at => "2011-03-21 14:33:58", 
          :updated_at => "2011-03-21 14:33:58", 
          :questions => true
        })

        blitz.convention_products.build([
          {:name => 'Donation towards Administrative costs', :description => '<p>Make a donation towards Administrative Costs</p>', :price => 1, :category => "Donation", :locked => false},
          {:name => 'Donation for the purchase and distrubtion of Scriptures', :description => '<p>Make a donation towards the costs of purchase and distribution of LSB Scriptures.</p>', :price => 1, :category => "Donation", :locked => false},
          {:name => "Donation to the cost of the Church Leaders' Lunch", :description => "Donation to the cost of the Church Leaders' Lunch", :price => 1, :category => "Donation", :locked => false}
        ])


        blitz.meal_exclusions.build([
          {:meal_date => '2011-09-21', :meal_no => 1},
          {:meal_date => '2011-09-21', :meal_no => 2},
          {:meal_date => '2011-09-22', :meal_no => 1},
          {:meal_date => '2011-09-23', :meal_no => 1},
          {:meal_date => '2011-09-23', :meal_no => 2},
          {:meal_date => '2011-09-24', :meal_no => 1},
          {:meal_date => '2011-09-24', :meal_no => 2},
          {:meal_date => '2011-09-25', :meal_no => 1}
        ])

        blitz.convention_questions.build([
          {:question => "Do you have a Gideon Identity Card?", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "If you are not staying in the base hotel, which part of London will you be staying in?", :answers => "", :display_type => "Text", :target => ['Gideon']},
          {:question => "If you are accredited, are you willing to speak at a church assignment?", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "Are you willing to be part of a support team for a church assignment?", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "Are you willing to use your own car to reach a Church Assignment and provide a lift for others?", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "Will you require a lift to reach a Church Assignment, if travel by car is the most efficient means of travel?", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "If you are accredited, are you be willing to take a Church Assignment on the Sunday evening?", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I/we intend to do scripture distribution and personal witnessing on Wednesday 21st September.", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I/we intend to do scripture distribution and personal witnessing on Thursday 22nd September.", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I/we intend to do scripture distribution and personal witnessing on Friday 23rd September.", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I/we intend to do scripture distribution and personal witnessing on Saturday 24th September.", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I am/we are willing to work on foot, using public transport in Central London", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I am willing to use my car in Central London as part of the Scripture Distribution", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I am willing to use my car outside Central London as part of the Scripture Distribution", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I am willing to drive a van provided by the Blitz Team in Central London as part of the Scripture Distribution.", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
          {:question => "I am willing to provide a van and drive it in Central London as part of the Scripture Distribution.", :answers => "Yes|No", :display_type => "Boolean", :target => ['Gideon']},
        ])
        
        

        blitz.save!
        
        product1 = ConventionProduct.find_by_convention_id_and_callname(blitz.id, "2011_9_25_2_adult_resident")
        product1.update_attribute(:price, 15)
        product2 = ConventionProduct.find_by_convention_id_and_callname(blitz.id, "2011_9_25_2_adult_visitor")
        product2.update_attribute(:price, 15)
      
      end
      
      
      

end