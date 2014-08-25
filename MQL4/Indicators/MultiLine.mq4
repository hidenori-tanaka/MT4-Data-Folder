//+------------------------------------------------------------------+
//|                                                    MultiLine.mq4 |
//|                                       Copyright 2014, Mr.Racoon. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Mr.Racoon."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

extern double MaxRate         = 110.0;
extern double MinRate         = 90.0;

extern double Line1Space      = 0.1;
extern color  Line1Color      = clrGreen;
extern int    Line1Style      = 2;
extern string LineStyleInfo   = "0=Solid,1=Dash,2=Dot,3=DashDot,4=DashDotDot";
extern double Line2Space      = 1.0;
extern color  Line2Color      = clrRed;
extern int    Line2Style      = 2;
extern string LineText        = "MultiLine ";

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit()
{
   //--- indicator buffers mapping
   
   //---
}

//+------------------------------------------------------------------+
//| Custom indicator Deinitialize function                         |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   //--- delete objects

   double AbSpace = Line1Space;
   for(double i=MinRate; i<=MaxRate; i+=AbSpace)
   {
      ObjectDelete(LineText+DoubleToStr(i,2));
   }
   

   AbSpace = Line2Space;
   for(double j=MinRate; j<=MaxRate; j+=AbSpace)
   {
      
      ObjectDelete(LineText+DoubleToStr(j,2));
   }
   
    
   //---
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
	// Normatlize MaxRate,MinRate
	MaxRate = MaxRate - MathFloor(MaxRate / Line1Space)*Line1Space + Line1Space;
	MinRate = MinRate - MathFloor(MaxRate / Line1Space)*Line1Space;
	
	DrawLines();
   
   //--- return value of prev_calculated for next call
   return(rates_total);
}

void DrawLines()
{
   
   double AbSpace = Line1Space;
   
   for(double i=MinRate; i<=MaxRate; i+=AbSpace)
   {
      string StringNr1 = DoubleToStr(i,2); // 2 digits number in object name
      if (ObjectFind(LineText+StringNr1) != 0) // HLine not in main chartwindow
      {                     
         
         ObjectCreate(LineText+StringNr1, OBJ_HLINE, 0, 0, i);
         ObjectSet(LineText+StringNr1, OBJPROP_STYLE, Line1Style);
         ObjectSet(LineText+StringNr1, OBJPROP_COLOR, Line1Color);
      }
      else
      {
         ObjectSet(LineText+StringNr1, OBJPROP_STYLE, Line1Style);
         ObjectSet(LineText+StringNr1, OBJPROP_COLOR, Line1Color);
    
 }
    }
    AbSpace = Line2Space;
    for(double j=MinRate; j<=MaxRate; j+=AbSpace)
    {
      string StringNr2 = DoubleToStr(j,2);
      if (ObjectFind(LineText+StringNr2) != 0)
      {
         ObjectCreate(LineText+StringNr2, OBJ_HLINE, 0, 0, j);
         
         ObjectSet(LineText+StringNr2, OBJPROP_STYLE, Line2Style);
         
         ObjectSet(LineText+StringNr2, OBJPROP_COLOR, Line2Color);
      
      }
      else
      {
         
         ObjectSet(LineText+StringNr2, OBJPROP_STYLE, Line2Style);
         
         ObjectSet(LineText+StringNr2, OBJPROP_COLOR, Line2Color);
      
      }
   
   }
   
   
   WindowRedraw();
}

//+------------------------------------------------------------------+
