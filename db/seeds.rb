# First create the account
account = Account.create!(name: 'Ferreteria el Rey')

# Then create the user with the account reference
User.create(name: 'Administrator', email: 'admin@admin.com', password: 123456, account_id: account.id)

# Now create the unit with the account reference
unit = Unit.find_or_create_by!(name: 'Pieza', account_id: account.id)

currencies = [
  { name: 'Dólar', code: 'USD', symbol: '$', exchange_rate: 7350, flag_url: 'https://flagcdn.com/w20/us.png', display: true },
  { name: 'Peso Argentino', code: 'ARS', symbol: '$', exchange_rate: 85.5, flag_url: 'https://flagcdn.com/w20/ar.png', display: true },
  { name: 'Real Brasileño', code: 'BRL', symbol: 'R$', exchange_rate: 1250, flag_url: 'https://flagcdn.com/w20/br.png', display: true }
]

# Add account_id to each currency
currencies.each do |currency_data|
  Currency.find_or_create_by!(code: currency_data[:code], account_id: account.id) do |currency|
    currency.update(currency_data.merge(account_id: account.id))
  end
end

company_settings = [
  { var: 'company_name', value: 'TU EMPRESA' },
  { var: 'company_owner', value: 'JUAN PEREZ PEREZ' },
  { var: 'company_address', value: 'RUTA 1 C/ AV. CABALLERO 1894, ENCARNACION' },
  { var: 'company_ruc', value: '000000000-0' },
  { var: 'company_phone', value: '0975 000000' },
  { var: 'company_email', value: 'contacto@tuempresa.com' },
  { var: 'company_invoice_number', value: '001-002-0001516' },
  { var: 'company_stamp_number', value: '17304657' },
  { var: 'company_stamp_validity', value: '01/07/2024 al 31/07/2025' },
  { var: 'receipt_final_message', value: '***¡Gracias por su compra!***' },
  { var: 'company_economic_activity', value: 'VENTA DE PRODUCTOS ELECTRÓNICOS' }
]

# Create settings without the account_id parameter
company_settings.each do |setting|
  Setting.set(setting[:var], setting[:value])
end
