String Base_URI = 'http://127.0.0.1:5000';

// on render base uri - https://kuruxtest.onrender.com

// String GET_COMPANY_LIST =
//     'https://kuruxtest.onrender.com/crud/get_company_list';

// String Auth_Link = 'https://kuruxtest.onrender.com/auth/validate';

// local-links
String GET_COMPANY_LIST = Base_URI + '/crud/get_company_list';

String Auth_Link = Base_URI + '/auth/validate';

String Single_Company_Details = Base_URI + '/crud/get_company_details';

String Avg_Buy_Price = Base_URI + '/price/avg_buy_price';

String Avg_Sell_Price = Base_URI + '/price/avg_sell_price';

String Balance_Check = Base_URI + '/wallet/check_balance';

String Balance_Add = Base_URI + ' /wallet/add_money';

String Balance_Send = Base_URI + '/wallet/send_money';

String Buy_Equity = Base_URI + '/equity/buy_equity';

String Sell_Equity = Base_URI + '/equity/sell_equity';

String User_Portfolio = Base_URI + '/user/portfolio';

String Buy_Order_List = Base_URI + '/user/buy_orders';

String Sell_Order_List = Base_URI + '/user/sell_orders';

String Cancel_Buy_Order = Base_URI + '/cancel/buy_order';

String Cancel_Sell_Order = Base_URI + '/cancel/sell_order';

String Order_History_List = Base_URI + '/user/order_history';

String Tran_History_List = Base_URI + '/user/tran_history';

String PinChange_Link = Base_URI + '/auth/change_pin';

String PassChange_Link = Base_URI + ' /auth/change_pass';
