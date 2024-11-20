# Restaurant App

This is a simple support restaurant system app build with **Flutter** (frontend) and **Meteor JS** (backend).

## Features

- Quick access enter to sale & show sale list on Dashboard divided by status (Printed, Open, Partial, Closed & Cancel) with multiple actions such as (Search, Print, Payment & Update)
- Switch branch and department
- Notification divided by type (Invoice, Chef Monitor & Stock Alert)
- Sale Table

  - Choose and search table
  - Show table list
  - Table change color with real time by status (Free, Busy, Printed Bill & Request Payment)

- Sale
  - show categories
  - show, search & load more products
  - switch sale
  - add new sale
  - show sale detail list
  - edit (Price, Discount, Note, Qty & Return Qty) or remove item on sale detail
  - sale operations
    - Merge
    - Transfer
    - Split
    - Customer count
    - Cancel
  - sale actions
    - Update table
    - Update customer
    - Cancel and copy
    - Print Sale (Invoice) to kitchen
    - Print to kitchen
    - Preview
    - Print
    - Payment
- Reports
  - Sale & Sale Summary
  - Sale Detail
  - Sale Detail Profit And Loss By Item
  - Sale Receipt

## Condition with user roles and modules

### Modules

- soup
- department
- chef-monitor
- skip-table
- tablet-orders
- multi-printers
- order-number
- decimal-qty

### ការផ្លាស់ប្ដូរតាម module នីមួយៗ:

- បង្ហាញលេខ `Order` ពីក្រោយលេខ `Invoice` ពេល module `order-number` active
- `Department` បង្ហាញពេល module `department` active

**Dashboard**

- `table transaction លក់` ចេញពេល user role == `show-dashboard`
- button `លក់` បង្ហាញពេល user role == `cashier` || `tablet-orders` && module `skip-table` មិន active
- button `លក់លឿន` បង្ហាញពេល user role == `insert-invoice` (Optional : ពេល module `skip-table` active ដូរ label ទៅ `លក់`)
- អាចចូល form លក់តាម invoice:
  - status == `Open`: user role == `cashier` || (user role == `tablet-orders` && invoice មិនទាន់ `request payment` )
- លើ invoice `Open` អាច `បង់លុយ` user role == `cashier`
- លើ invoice `Partial` អាច `បង់លុយ` user role == `cashier`

**Sale Table (រើសតុ)**

- user អាចចូល `form លក់` ពេល:
  - បើ user role == `insert-invoice`
  - user role == `cashier` || `tablet-orders` អាចចូលបានបើ `table status == 'busy' || 'close'` នៅក្នុងតុនិង

**Sale (លក់)**

- `ប្ដូរតុ` បង្ហាញពេល module `skip-table` មិន active
- `Print ទៅ Kitchen` បង្ហាញពេល user role != `tablet-orders`
- `Print Invoice ទៅ Kitchen` បង្ហាញពេល module `chef-monitor` active
- `Print` បង្ហាញពេល user role != `tablet-orders`
- `Preview` បង្ហាញពេល user role == `tablet-orders`
- `បញ្ចូល` បង្ហាញពេល user role != `tablet-orders`
- `ផ្ទេរ` បង្ហាញពេល user role != `tablet-orders`
- `បំបែក` បង្ហាញពេល user role != `tablet-orders`
- `បោះបង & ចំលង` បង្ហាញពេល user role != `tablet-orders`
- input `returnQty` ចេញពេលមាន module `soup` & user role != `tablet-orders`
- input `qty`, `returnQty` អាចបញ្ចូលតម្លៃ Decimal បាន (អស់ធំ 2 ខ្ទង់) ពេលមាន module `decimal-qty`
- item មិនអាចលុបបានពេល `print bill រួច` || user role == `tablet-orders` ហើយ item មិនមែន `draft`
- item qty មិនអាចកែបានពេល `print bill រួច` || `print ទៅ kitchen រួច` || user role == `tablet-orders` ហើយ item មិនមែន `draft` || item status != `Done`
- មិនបាច់បង្ហាញ លេខតុ, ជាន់ ពេល module `skip-table` active
- បិទមិនអោយ `ថែម invoice` បានបើ user role != `insert-invoice`

**Notification**

- tab `Invoice` បង្ហាញពេល module `tablet-orders` active && user role == `cashier`
- tab `Chef Monitor` បង្ហាញពេល module `chef-monitor` active
- tab `Stock Alert` បង្ហាញពេល module `purchase` active
- notification `Invoice` អាចលុបបានបើ user role == `cashier`

## Demo

## Changelog

### v 0.0.1

- init

## Bug Fixes

- none

## Breaking Change

- none

## More Related

[Flutter Meteor Template App](/README.md)
