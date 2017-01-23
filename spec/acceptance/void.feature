Feature: VOID

  Scenario: Refund credit card charge
    Given VCR cassette is "acceptance/void/card_charge"

    When dispatch EntryTran request
      | Name     | Value                          |
      | ShopID   | <%= ENV['GMO_PG_SHOP_ID'] %>   |
      | ShopPass | <%= ENV['GMO_PG_SHOP_PASS'] %> |
      | OrderID  | <%= order_id %>                |
      | JobCd    | CAPTURE                        |
      | Amount   | 1980                           |
      | TdFlag   | 0                              |
    Then response has no error

    When dispatch ExecTran request
      | Name         | Value                        |
      | AccessID     | <%= @response.access_id %>   |
      | AccessPass   | <%= @response.access_pass %> |
      | OrderID      | <%= order_id %>              |
      | Method       | 1                            |
      | CardNo       | 4111111111111111             |
      | Expire       | 1901                         |
      | SecurityCode | 123                          |
    Then response has no error

    When dispatch AlterTran request
      | Name       | Value                                      |
      | ShopID     | <%= ENV['GMO_PG_SHOP_ID'] %>               |
      | ShopPass   | <%= ENV['GMO_PG_SHOP_PASS'] %>             |
      | AccessID   | <%= histories[0][:response].access_id %>   |
      | AccessPass | <%= histories[0][:response].access_pass %> |
      | JobCd      | VOID                                       |
    Then response has no error

  Scenario: Refund member charge
    Given VCR cassette is "acceptance/void/member_charge"

    When dispatch SaveMember request
      | Name     | Value                          |
      | SiteID   | <%= ENV['GMO_PG_SITE_ID'] %>   |
      | SitePass | <%= ENV['GMO_PG_SITE_PASS'] %> |
      | MemberID | <%= member_id %>               |
    Then response has no error

    When dispatch SaveCard request
      | Name         | Value                          |
      | SiteID       | <%= ENV['GMO_PG_SITE_ID'] %>   |
      | SitePass     | <%= ENV['GMO_PG_SITE_PASS'] %> |
      | MemberID     | <%= member_id %>               |
      | SeqMode      | 1                              |
      | CardNo       | 4111111111111111               |
      | Expire       | 1901                           |
    Then response has no error

    When dispatch EntryTran request
      | Name     | Value                          |
      | ShopID   | <%= ENV['GMO_PG_SHOP_ID'] %>   |
      | ShopPass | <%= ENV['GMO_PG_SHOP_PASS'] %> |
      | OrderID  | <%= order_id %>                |
      | JobCd    | CAPTURE                        |
      | Amount   | 1980                           |
      | TdFlag   | 0                              |
    Then response has no error

    When dispatch ExecTran request
      | Name         | Value                          |
      | AccessID     | <%= @response.access_id %>     |
      | AccessPass   | <%= @response.access_pass %>   |
      | OrderID      | <%= order_id %>                |
      | Method       | 1                              |
      | SiteID       | <%= ENV['GMO_PG_SITE_ID'] %>   |
      | SitePass     | <%= ENV['GMO_PG_SITE_PASS'] %> |
      | MemberID     | <%= member_id %>               |
      | SeqMode      | 1                              |
      | CardSeq      | 0                              |
      | SecurityCode | 123                            |
    Then response has no error

    When dispatch AlterTran request
      | Name       | Value                                      |
      | ShopID     | <%= ENV['GMO_PG_SHOP_ID'] %>               |
      | ShopPass   | <%= ENV['GMO_PG_SHOP_PASS'] %>             |
      | AccessID   | <%= histories[2][:response].access_id %>   |
      | AccessPass | <%= histories[2][:response].access_pass %> |
      | JobCd      | VOID                                       |
    Then response has no error
