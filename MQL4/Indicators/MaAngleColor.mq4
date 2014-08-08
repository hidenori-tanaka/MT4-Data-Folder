//+------------------------------------------------------------------+
//|                                                 MaAngleColor.mq4 |
//|                                       Copyright 2014, Mr.Racoon. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Mr.Racoon."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_plots   3

//--- plot MA_FLAT
#property indicator_label1  "MA Flat"
#property indicator_type1   DRAW_LINE
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
#property indicator_color1  clrGreen

//--- plot MA_UP
#property indicator_label2  "MA Up"
#property indicator_type2   DRAW_LINE
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
#property indicator_color2  clrBlue

//--- plot MA_DOWN
#property indicator_label3  "MA Down"
#property indicator_type2   DRAW_LINE
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
#property indicator_color3  clrRed

//--- input parameters
input int      Period=40;
input double   Angle=10.0;
input int      MaType=0;
input int      Average=12;

//--- indicator buffers
double         MABuffer1[];
double         MABuffer2[];
double         MABuffer3[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
   
    SetIndexBuffer(0,MABuffer1);
    SetIndexBuffer(1,MABuffer2);
    SetIndexBuffer(2,MABuffer3);
      
//---
    return(INIT_SUCCEEDED);
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
//---
    int limit = Bars - IndicatorCounted();
    int i;
    for(i= limit-1 ; i>=0 ; i--){
        MABuffer1[i] = iMA(NULL, 0, Period, 0, MaType, PRICE_CLOSE, i);

        if(i<limit-i-Average){
         double Slope;
         Slope = calcSlope(MABuffer1, i, Average);
         Print("Slope=", Slope);
      
         if(Slope > Angle ){
            Print("Up");

            MABuffer2[i] = MABuffer1[i]; 

         }else if(Slope < -1*Angle){
            Print("Down");
            MABuffer3[i] = MABuffer1[i];
         }

      }
    }
   
//--- return value of prev_calculated for next call
    return(rates_total);
}

double calcSlope(double& buff[], int offset, int n)
{
    int i;

    double a, b, c, d, e;
    a = 0;
    b = 0;
    c = 0;
    d = 0;
    e = 0;
  
   //Print("Buff[3]=", buff[offset+2], " Buff[2]=", buff[offset+1], " Buff[0]=", buff[offset]);
    
    for(i=n ; i>0 ; i--){
        a += (n-i+1)*buff[offset+i-1];
        b += (n-i+1);
        c += buff[offset+i-1];
        d += (n-i+1)*(n-i+1); 
        e += (n-i+1);
    }
    
    a = (n*a - b*c)/(n*d-e*e);
    a *= 60*5*10;
   return(a);
}

//+------------------------------------------------------------------+

