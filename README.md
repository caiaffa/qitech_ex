# QI Tech Elixir

Elixir wrapper for [QI Tech](https://www.qitech.com.br/documentacao?file=111) API.

## Installation

Add `qitech_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:qitech_ex, "~> 0.1.0"}
  ]
end
```

## Configuration 

The default behaviour is to configure using the application environment:

```elixir
# config/config.exs

config :qitech_ex,
  sandbox: true, # for production environment put false
  simplify_response: true, 
  api_client_key: "QI Tech API Client Key",
  client_adapter_opts: [adapter: [recv_timeout: 10_000]], # For more detail see Tesla Adapter
  public_key: " -----BEGIN PUBLIC KEY-----",
  private_key: "-----BEGIN EC PRIVATE KEY-----"
  ```

## Examples

Create a debt.

```elixir

body = %{
  "additional_data" =>  %{
  },
  "borrower" =>  %{
    "address" =>  %{
      "city" =>  "example",
      "complement" =>  "example",
      "neighborhood" =>  "example",
      "number" =>  "example",
      "postal_code" =>  "example",
      "state" =>  "RJ",
      "street" =>  "example"
    },
    "document_identification_number" =>  "",
    "email" =>  "example@example.com",
    "individual_document_number" =>  "xxxxxxxxxxx",
    "mother_name" =>  "",
    "name" =>  "example",
    "nationality" =>  "",
    "person_type" =>  "natural",
    "phone" =>  %{
      "area_code" =>  "00",
      "country_code" =>  "055",
      "number" =>  "000000000"
    },
    "profession" =>  ""
  },
  "disbursement_bank_accounts" =>  [
    %{
      "account_digit" =>  "0",
      "account_number" =>  "00000",
      "bank_code" =>  "000",
      "branch_number" =>  "0000",
      "document_number" =>  "xxxxxxxxxxxxxxx",
      "name" =>  "example",
      "percentage_receivable" =>  100
    }
  ],
  "financial" =>  %{
    "annual_interest_rate" =>  0.966751,
    "credit_operation_type" =>  "ccb",
    "disbursed_amount" =>  5000.0,
    "disbursement_date" =>  "2021-03-05",
    "fine_configuration" =>  %{
      "contract_fine_rate" =>  0.02,
      "interest_base" =>  "calendar_days",
      "monthly_rate" =>  0.01
    },
    "first_due_date" =>  "2021-03-10",
    "interest_grace_period" =>  0,
    "interest_subsidy_amount" =>  0,
    "interest_subsidy_percentage" =>  0,
    "interest_type" =>  "pre_price_days",
    "issue_date" =>  "2021-02-27",
    "number_of_installments" =>  2,
    "principal_grace_period" =>  0,
    "rebate" =>  35.0
  },
  "guarantors" =>  [],
  "installments" =>  [],
  "simplified" =>  true
}


body |> QITech.API.Debt.create()

# Response
{:ok,
 %{
   body: %{
     "data" => %{
       "assignment_amount" => 0000.000,
       "borrower" => %{
         "document_number" => "xxxxxxxxxxx",
         "name" => "exaple"
       },
       "contract" => %{
         "number" => "0000000/LF",
         "urls" => [""]
       },
       "contract_fee_amount" => 8.41,
       "contract_fees" => [%{"fee_amount" => 8.41, "fee_type" => "tac"}],
       "external_contract_fee_amount" => 00.0,
       "external_contract_fees" => [
         %{
           "fee_amount" => 00.00,
           "fee_type" => "tac_tax_free",
           "net_fee_amount" => 00.00,
           "tax_amount" => 0.0
         }
       ],
       "installments" => [
         %{
           "additional_costs" => [],
           "bank_slip_key" => nil,
           "business_due_date" => "2021-03-10",
           "calendar_days" => 5,
           "digitable_line" => nil,
           "due_date" => "2021-03-10",
           "due_interest" => 0.0,
           "due_principal" => 000.00,
           "fine_amount" => nil,
           "has_interest" => true,
           "installment_key" => "xxxxxxxxx-xxxx-xxxx-xxxxxxx",
           "installment_number" => 1,
           "installment_status" => "created",
           "installment_type" => "principal",
           "paid_amount" => 0.0,
           "paid_at" => nil,
           "post_fixed_amount" => 0,
           "pre_fixed_amount" => 5.000,
           "principal_amortization_amount" => 00.00,
           "tax_amount" => 0.00,
           "total_amount" => 00.15,
           "workdays" => 3.0
         },
         %{
           "additional_costs" => [],
           "bank_slip_key" => nil,
           "business_due_date" => "2021-04-12",
           "calendar_days" => 31,
           "digitable_line" => nil,
           "due_date" => "2021-04-10",
           "due_interest" => 0.0,
           "due_principal" => 000.0000,
           "fine_amount" => nil,
           "has_interest" => true,
           "installment_key" => "xxxxxxxxx-xxxx-xxxx-xxxxxxx",
           "installment_number" => 2,
           "installment_status" => "created",
           "installment_type" => "principal",
           "paid_amount" => 0.0,
           "paid_at" => nil,
           "post_fixed_amount" => 0,
           "pre_fixed_amount" => 00.0000,
           "principal_amortization_amount" => 000.000,
           "tax_amount" => 0.00,
           "total_amount" => 000.00,
           "workdays" => 0.0
         }
       ],
       "net_external_contract_fee_amount" => 218.65,
       "requester_identifier_key" => "xxxxxxxxx-xxxx-xxxx-xxxxxxx" 
     },
     "event_datetime" => "2021-02-27 01:37:41",
     "key" => "xxxxxxxxx-xxxx-xxxx-xxxxxxx",
     "status" => "waiting_signature",
     "webhook_type" => "debt"
   },
   status: 201
 }}
```
Retrieve a list of debt.

```elixir
QITech.API.Debt.get([page_size: 1]) 

# Response
{:ok,
 %{
   body: %{
     "data" => [
       %{
         "net_external_contract_fee_amount" => 00.00,
         "payment_and_settlement_agent" => nil,
         "credit_operation_type" => %{
           "created_at" => "2019-03-15T13:09:34",
           "enumerator" => "ccb",
           "translation_path" => "co.CreditOperationType.ccb"
         },
         "credit_operation_status" => %{
           "created_at" => "2019-03-15T13:09:34",
           "enumerator" => "waiting_signature",
           "translation_path" => "co.CreditOperationStatus.waiting_signature"
         },
         "share_quantity" => 2,
         "prefixed_interest_rate" => %{
           "annual_rate" => 0.000,
           "created_at" => "2021-02-27T01:37:34",
           "daily_rate" => 6.4803e-4,
           "interest_base" => %{
             "created_at" => "2020-09-01T14:57:56",
             "enumerator" => "calendar_days_365",
             "translation_path" => "co.InterestBase.calendar_days_365",
             "year_days" => 365
           },
           "monthly_rate" => 0.000
         },
         "principal_grace_period" => 0,
         "issuer_name" => "example",
         "rebate_account" => %{
           "account_branch" => "00",
           "account_digit" => "00",
           "account_number" => "00",
           "created_at" => "2020-10-22T16:04:28",
           "document_number" => "0000",
           "financial_institutions" => %{
             "code_number" => 00,
             "ispb" => 0000,
             "name" => "example"
           },
           "financial_institutions_code_number" => 237,
           "name" => "example"
         },
         "calculus_correction" => nil,
         "operation_type" => %{
           "created_at" => "2020-01-23T19:05:26",
           "enumerator" => "structured_operation",
           "translation_path" => "co.OperationType.structured_operation"
         },
         "custodian" => %{
           "created_at" => "2019-10-10T14:22:43",
           "enumerator" => "qi_scd",
           "translation_path" => "co.Custodian.qi_scd"
         },
         "disbursement_date" => "2021-03-05",
         "endorsement" => nil,
         "events" => [],
         "base_iof" => 0.00,
         "central_depository" => nil,
         "external_contract_fees" => [
           %{
             "amount" => 00.0,
             "amount_type" => %{
               "created_at" => "2020-02-10T13:32:52",
               "enumerator" => "percentage"
             },
             "created_at" => "2021-02-27T01:37:34",
             "fee_amount" => 00.65,
             "fee_type" => %{
               "created_at" => "2020-09-04T10:47:21",
               "enumerator" => "tac_tax_free"
             },
             "net_fee_amount" => 00.65,
             "tax_amount" => 0.0
           }
         ],
         "contract_number" => "000000000/LF",
         "total_iof" => 9.2,
         "disbursed_issue_amount" => 0000.65,
         "assignment_amount" => 0000.00,
         "isin_number" => nil,
         "registration_institution" => %{
           "created_at" => "2019-10-10T14:22:44",
           "enumerator" => "qi_scd",
           "translation_path" => "co.RegistrationInstitution.qi_scd"
         },
         "operation_extra_fields" => nil,
         "origin_key" => "xxxxx-xxx-xxxx-xxxxx",
         "attached_document_list" => [
           %{
             "created_at" => "2021-02-27T01:37:41",
             "document_key" => "xxxxx-xxx-xxxx-xxxxx",
             "document_type" => %{
               "created_at" => "2020-09-03T17:53:17",
               "enumerator" => "ccb_pre_price_days",
               "translation_path" => "co.DocumentType.ccb_pre_price_days"
             },
             "document_url" => "",
             "related_party_key" => nil,
             "signature_required" => true,
             "signature_url" => nil,
             "signed" => false
           }
         ],
         "modality" => %{
           "code" => "0499",
           "created_at" => "2021-01-11T17:30:53",
           "description" => "outros financiamentos",
           "visible" => true
         },
         "first_due_date_delay" => nil,
         "resource_source_account" => %{
           "created_at" => "2019-03-15T13:09:43",
           "enumerator" => "treasury_account",
           "translation_path" => "co.ResourceSourceAccount.treasury_account"
         },
         "interest_subsidy_percentage" => 0.0,
         "after_disbursement_actions" => [],
         "requester_key" => "xxxxx-xxx-xxxx-xxxxx",
         "post_fixed_interest_rate" => nil,
         "related_party_list" => [
           %{
             "address" => %{
               "city" => "example",
               "complement" => "example",
               "created_at" => "2021-02-27T01:37:34",
               "neighborhood" => "example",
               "number" => "88",
               "postal_code" => "example",
               "state" => "RJ",
               "street" => "example"
             },
             "attached_document_list" => [],
             "birth_date" => nil,
             "birth_place" => nil,
             "cnae_code" => nil,
             "company_document_number" => nil,
             "created_at" => "2021-02-27T01:37:34",
             "document_identification_number" => "",
             "email" => "example@example.com",
           }
         ],
         "interest_subsidy_amount" => 0.0,
         "disbursement_callback" => nil,
         "requester_name" => "example",
         "contract_fee_amount" => 8.41,
         "document_certifier" => %{
           "created_at" => "2020-02-07T17:14:42",
           "enumerator" => "clicksign",
           "translation_path" => "co.DocumentCertifier.clicksign"
         },
         "number_of_installments" => 2,
         "early_settlement_configuration" => %{
           "created_at" => "2021-02-27T01:37:34",
           "early_settlement_configuration_type" => %{
             "created_at" => "2019-03-15T13:09:36",
           },
           "effective_end_date" => nil,
         },
         "tax_configuration" => %{
           "created_at" => "2019-03-15T13:09:32",
           "iof_additional_rate" => 0.00,
         },
         "fine_configuration" => %{"contract_fine_rate" => 0.02, ...},
         "disbursement_end_date" => "2021-03-05",
         ...
       }
     ],
     "pagination" => %{ 
       "current_page" => 1,
       "next_page" => 2,
       "rows_per_page" => 1,
       "total_pages" => 7,
       "total_rows" => 7
     },
     "totals" => %{"issue_total_amount" => "00.00"}
   },
   status: 200
 }}
```

Retrieve a debt.

```elixir
QITech.API.Debt.get([key: "8b0f78d5-2574-442f-b5da-1f4752c45f48"])

# Response
%{
   body: %{
     "data" => %{
       "additional_iof" => 0.0,
       "base_iof" => 0.0,
       "borrower" => %{
         "document_number" => "xxxxxxxxxxx",
         "name" => "example"
       },
       "contract_fee_amount" => 0.00,
       "contract_fees" => [
         %{
           "amount" => 0.0,
           "amount_type" => %{
             "created_at" => "2020-02-10T13:32:52",
             "enumerator" => "percentage"
           },
           "created_at" => "2021-02-27T01:37:34",
           "fee_amount" => 0.00,
           "fee_type" => %{
             "created_at" => "2020-02-10T13:33:16",
             "enumerator" => "tac"
           }
         }
       ],
       "contract_number" => "00000/LF",
       "disbursed_issue_amount" => 00.00,
       "disbursement_account" => [
         %{
           "account_branch" => "00",
           "account_digit" => "0",
           "account_number" => "00",
           "amount_receivable" => nil,
           "created_at" => "2021-02-27T01:37:34",
           "document_number" => "xxxxxxxxxxx",
           "financial_institutions" => %{
             "code_number" => 00,
             "ispb" => 00,
             "name" => "example"
           },
           "financial_institutions_code_number" => 000,
           "name" => "example",
           "percentage_receivable" => 100.0,
           "transaction_key" => nil,
           "webhook_key" => nil
         }
       ],
       "disbursement_date" => "2021-03-05",
       "external_contract_fee_amount" => 00.00,
       "external_contract_fees" => [
         %{
           "amount" => 00.0,
           "amount_type" => %{
             "created_at" => "2020-02-10T13:32:52",
             "enumerator" => "percentage"
           },
           "created_at" => "2021-02-27T01:37:34",
           "fee_amount" => 00.00,
           "fee_type" => %{
             "created_at" => "2020-09-04T10:47:21",
             "enumerator" => "tac_tax_free"
           },
           "net_fee_amount" => 00.00,
           "tax_amount" => 0.0
         }
       ],
       "installments" => [
         %{
           "additional_costs" => [],
           "bank_slip_key" => nil,
           "business_due_date" => "2021-03-10",
           "calendar_days" => 5,
           "digitable_line" => nil,
           "due_date" => "2021-03-10",
           "due_interest" => 0.0,
           "due_principal" => 00.91,
           "fine_amount" => nil,
           "has_interest" => true, 
           "installment_key" => "xxxx-xxx-xxx-xxx-xxxxxxxxx",
           "installment_number" => 1,
           "installment_status" => "created",
           "installment_type" => "principal",
           "paid_amount" => 0.0,
           "paid_at" => nil,
           "post_fixed_amount" => 0.0,
           "pre_fixed_amount" => 5.00,
           "principal_amortization_amount" => 00.00,
           "tax_amount" => 0.00,
           "total_amount" => 00.00,
           "workdays" => 3
         },
         %{
           "additional_costs" => [],
           "bank_slip_key" => nil,
           "business_due_date" => "2021-04-12",
           "calendar_days" => 31,
           "digitable_line" => nil,
           "due_date" => "2021-04-10",
           "due_interest" => 0.0,
           "due_principal" => 00.00,
           "fine_amount" => nil,
           "has_interest" => true,
           "installment_key" => "xxxx-xx-xxxx-xxxx-xxxxxxx",
           "installment_number" => 2,
           "installment_status" => "created",
           "installment_type" => "principal",
           "paid_amount" => 0.0,
           "paid_at" => nil,
           "post_fixed_amount" => 0.0,
           "pre_fixed_amount" => 00.00,
           "principal_amortization_amount" => 00.00,
           "tax_amount" => 0.00,
           "total_amount" => 00.00,
           "workdays" => 21
         }
       ],
       "issue_amount" => 00.00,
       "net_external_contract_fee_amount" => 00.00,
       "post_fixed_interest_base" => %{
         "created_at" => "2019-03-15T13:09:33",
         "enumerator" => "workdays",
         "translation_path" => "co.InterestBase.workdays",
         "year_days" => 252
       },
       "post_fixed_interest_rate" => nil,
       "prefixed_interest_rate" => %{
         "annual_rate" => 0.00,
         "created_at" => "2021-02-27T01:37:34",
         "daily_rate" => 6.4803e-4,
         "interest_base" => %{
           "created_at" => "2020-09-01T14:57:56",
           "enumerator" => "calendar_days_365",
           "translation_path" => "co.InterestBase.calendar_days_365",
           "year_days" => 365
         },
         "monthly_rate" => 0.00
       },
       "purchaser_document_number" => nil,
       "total_iof" => 0.0
     },
     "operation_key" => "xxxxx-xxxxx-xxxx-xxxx-xxxxxxxx",
     "status" => "waiting_signature",
     "webhook_type" => "debt"
   },
   status: 200
 }}
```

Cancel a debt.

```elixir
QITech.API.Debt.cancel("d4935335-5263-430a-868d-505a7ce9d8f0")

# Response
{:ok, %{body: %{}, status: 201}}
```

## Contributing

Feedback, feature requests, and fixes are welcomed and encouraged.

1. Fork it (https://github.com/caiaffa/qitech_ex/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details


