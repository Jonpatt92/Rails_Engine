require 'csv'

task :import_csv => :environment do
  all_files = ["db/data/merchants.csv",
                   "db/data/items.csv",
               "db/data/customers.csv",
                "db/data/invoices.csv",
           "db/data/invoice_items.csv",
            "db/data/transactions.csv"]
            
  all_files.each do |file|
    file_name = file.gsub('db/data/', '').gsub('.csv', '')
    CSV.foreach(file, :headers => true) do |row|
      file_name.classify.constantize.create!(row.to_hash)
    end
  end
end

# Alternatively:
# until all_files.count == 0
#   file = all_files.shift
#   file_name = file.gsub('db/data/', '').gsub('.csv', '')
#
#   CSV.foreach(file, :headers => true) do |row|
#     file_name.classify.constantize.create!(row.to_hash)
#   end
# end
