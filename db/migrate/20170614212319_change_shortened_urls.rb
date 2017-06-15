class ChangeShortenedUrls < ActiveRecord::Migration[5.0]
  def change
    change_column :shortened_urls, :short_url, :string, null: false
  end
end
