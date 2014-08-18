//+------------------------------------------------------------------+
//|                                                        MyLib.mqh |
//|                                       Copyright 2014, Mr.Racoon. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Mr.Racoon."
#property link      "http://www.mql5.com"
#property strict

#include <stderror.mqh>
#include <stdlib.mqh>

//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
#define MY_OPENPOS  6
#define MY_LIMITPOS 7
#define MY_STOPPOS  8
#define MY_PENDPOS  9
#define MY_BUYPOS   10
#define MY_SELLPOS  11
#define MY_ALLPOS   12

//+------------------------------------------------------------------+
//| imports                                                      |
//+------------------------------------------------------------------+
#import "MyLib.ex4"

// 現在のポジションのロット数(+:買い -:売り)
double MyCurrentOrders(int type, int magic);

// 注文を送信する
bool MyOrderSend(int type, double lots, double price, int slippage,
    double sl, double tp, string comment, int magic);
    
// オープンポジションを変更する
bool MyOrderModify(double sl, double tp, int magic);

// オープンポジションを決済する
bool MyOrderClose(int slippage, int magic);

// 注文をキャンセルする
bool MyOrderDelete(int magic);

#import
