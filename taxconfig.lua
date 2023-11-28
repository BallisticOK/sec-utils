Config = {}

Config.EconomyTax = {
    ["low"] = 100000,
    ["medium"] = 2500000,
    ["high"] = 5000000,
    ["ultra"] = 10000000,
    ["extreme"] = 50000000
}

Config.EconomyTaxPercentage = {
    ["low"] = 0.01,
    ["medium"] = 0.1,
    ["high"] = 0.1,
    ["ultra"] = 0.2,
    ["extreme"] = 0.4
}

Config.EconomyTaxInterval = 240

Config.CarTaxRate = math.random(8, 36)
Config.CarTaxInterval = 80

Config.HouseTaxRate = math.random(81, 500)
Config.HouseTaxInterval = 120

Config.TaxesAccountEnabled = true
Config.TaxesAccount = {
    accountType = "business",
    -- playerCitizenId = 'XX1111',
    business_name = "centrelink"
    -- business_id = 1
}

Config.Lang = {
    player_tax = "Player tax recieved $%d",
    car_tax = "Vehicle tax recieved $%d",
    house_tax = "House tax recieved $%d"
}
