class CreateRefreshTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :refresh_tokens do |t|
      t.string :user_id
      t.string :token_hash
      t.string :ip_address
      t.string :token_pair_id
      t.boolean :revoked

      t.timestamps
    end
  end
end
