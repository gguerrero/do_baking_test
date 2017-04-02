# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

bank_a = Bank.create!(name: "Bank A")
bank_b = Bank.create!(name: "Bank B")

bank_a_account_a = Account.create!(name: "Account A", holder: "Jim", bank: bank_a, current_credit: 25000)
bank_a_account_b = Account.create!(name: "Account B", holder: "Sam", bank: bank_a, current_credit: 3000)
bank_b_account_a = Account.create!(name: "Account A", holder: "Emma", bank: bank_b, current_credit: 1500)
bank_b_account_b = Account.create!(name: "Account B", holder: "Thomas", bank: bank_b, current_credit: 0)

TransferType.create!(name: "INTRA-BANK", commission: 0, max_per_transfer: nil)
TransferType.create!(name: "INTER-BANK", commission: 5, max_per_transfer: 1000)
