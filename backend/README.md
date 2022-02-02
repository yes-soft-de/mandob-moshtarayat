### APIs documentation:
https://documenter.getpostman.com/view/11814853/Tzm5GwUe


- in 'order' table we have 'orderType' field that takes the values ​​(1 - 2 - 3):

    1: product order

    2: special order

    3: send order

- RatingEntity for (/rating) route :
itemID : The item you will rate.
itemType : type of The item you will rate (captain or client or product or store).
rating : 1 - 2 - 3 - 4 - 5.
userType : Who is the user who rating? if store send (store). For fear of conflict because we rely on the store profile id. 
note : only in store app, send this "userType":"store" .