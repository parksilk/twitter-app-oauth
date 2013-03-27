class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.string :text
  		t.string :job_id
  		t.references :user
  		t.timestamps
  	end
  end
end