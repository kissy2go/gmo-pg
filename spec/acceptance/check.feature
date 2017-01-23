Feature: CHECK

  Scenario: Check credit card availability by number
    Given VCR cassette is "acceptance/check/by_number"

    When dispatch EntryTran request
      | Name     | Value                          |
      | ShopID   | <%= ENV['GMO_PG_SHOP_ID'] %>   |
      | ShopPass | <%= ENV['GMO_PG_SHOP_PASS'] %> |
      | OrderID  | <%= order_id %>                |
      | JobCd    | CHECK                          |
    Then response has no error

    When dispatch ExecTran request
      | Name         | Value                        |
      | AccessID     | <%= @response.access_id %>   |
      | AccessPass   | <%= @response.access_pass %> |
      | OrderID      | <%= order_id %>              |
      | CardNo       | 4111111111111111             |
      | Expire       | 1901                         |
      | SecurityCode | 123                          |
    Then response has no error

  Scenario: Check credit card availability by member card
    Given VCR cassette is "acceptance/check/by_member_card"

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
      | JobCd    | CHECK                          |
    Then response has no error

    When dispatch ExecTran request
      | Name         | Value                          |
      | AccessID     | <%= @response.access_id %>     |
      | AccessPass   | <%= @response.access_pass %>   |
      | OrderID      | <%= order_id %>                |
      | SiteID       | <%= ENV['GMO_PG_SITE_ID'] %>   |
      | SitePass     | <%= ENV['GMO_PG_SITE_PASS'] %> |
      | MemberID     | <%= member_id %>               |
      | SeqMode      | 1                              |
      | CardSeq      | 0                              |
      | SecurityCode | 123                            |
    Then response has no error
