//+------------------------------------------------------------------+
//|                                                GenericSystme.mq4 |
//|                                       Copyright 2014, Mr.Racoon. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Mr.Racoon."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

#include <MyLib.mqh>

// マジックナンバー
#define MAGIC   20140817
#define COMMENT "GenericSystem"

// 外部パラメータ
extern double Lots = 0.1;
extern int Slippage = 3;

// エントリーシグナル
int EntrySignal(int magic)
{
    // オープンポジションの計算
    double pos = MyCurrentOrders(MY_OPENPOS, magic);
    
    int ret = 0;
    
    // if(pos <= 0 && 買いシグナル) ret = 1;
    // if(pos >= 0 && 売りシグナル) ret  = -1;
    return(ret);
}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
      
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
      
  }
  
  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    // エントリーシグナル
    int sig_entry = EntrySignal(MAGIC);
    
    // 買い注文
    if(sig_entry > 0)
    {
        MyOrderClose(Slippage, MAGIC);
        MyOrderSend(OP_BUY, Lots, Ask, Slippage, 0, 0, COMMENT, MAGIC);
    }
    
    // 売り注文
    if(sig_entry < 0)
    {
        MyOrderClose(Slippage, MAGIC);
        MyOrderSend(OP_SELL, Lots, Bid, Slippage, 0, 0, COMMENT, MAGIC);        
    }
    return;
}

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
