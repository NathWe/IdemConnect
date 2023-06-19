@isTest
public with sharing class TestDataFactory {
    /**
    * Method to generate Accounts
    * @param Integer : number of accounts to create
    * @return List<Account>
    */
    public static List<Account> generateAccountsList(Integer numberOfAccountsToCreate) {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < numberOfAccountsToCreate; i++) {
            Account acc = new Account(Name = 'Test'+i);
            accList.add(acc);
        }
        insert accList;
        return accList;
    }


    /**
     * Method to generate Orders
     * @param List<Account> : related accounts
     * @return List<Order>
     */
    public static List<Order> generateOrdersList(List<Account> accountsToAddOrder) {
        List<Order> ordersList = new List<Order>();
        Id PricebookId = Test.getStandardPricebookId();
        for (Account a : accountsToAddOrder) {
            Order orderToAdd = new Order(
            AccountId = a.Id,
            EffectiveDate = Date.today() +7,
            Pricebook2Id = PricebookId,
            Status ='Draft');
            ordersList.add(orderToAdd);
        }
        insert ordersList;
        return ordersList;
    }

    /**
     * Method to generate PBE
     */

    /**
     * Method to generate a Pricebook
     * @return Pricebook2
     */
    public static Pricebook2 generatePricebook() {
        Pricebook2 fashaPriceBook = new Pricebook2(Name = 'Catalogue iDEM Connect - Test',
                                                   Description = 'Pricebook for test', 
                                                   IsActive = true);
        insert fashaPriceBook;
        return fashaPriceBook;
    }

    /**
     * Method to generate generatePriceBookEntry
     * @param Product2 : related product
     * @return PricebookEntry
     */
    public static PricebookEntry generatePriceBookEntry(Product2 product) {
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 45,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }

    /**
     * Method to generate generateProduct
     * @return Product2
     */
    public static Product2 generateProduct() {
        Product2 forfait1 = new Product2(Name = 'Forfait 1', Family = 'Fibre',  IsActive = true);
        insert forfait1;
        return forfait1;
    }

    /**
     * Method to add Order Item to an Order
     */
    public static OrderItem generateOrderItem(Order ordr, Product2 product, PricebookEntry pbe) {
        OrderItem oi = new OrderItem(
            OrderId = ordr.Id,
            Product2Id = product.Id,
            PricebookEntryId = pbe.Id,
            Quantity = 1,
            UnitPrice = 45
        );
        insert oi;
        return oi;
    }
}