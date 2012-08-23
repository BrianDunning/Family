class CreateFamilynames < ActiveRecord::Migration
  def self.up
    create_table :familynames do |t|
  		t.string :sex, :limit => 1, :null => false
  		t.string :firstname,  :limit => 30, :null => false
  		t.string :middlenames,  :limit => 30
  		t.string :lastname, :limit => 30, :null => false
  		t.string :notes,  :limit => 150
      t.timestamps
    end
  end

  def self.down
  	drop_table :familynames
  end

end
