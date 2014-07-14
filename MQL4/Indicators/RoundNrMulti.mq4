//**************************************************
//*  RoundNrMulti.mq4 (No Copyright)               *
//*                                                *
//*  Draws horizontal lines at round price levels  *
//*                                                *
//*  Written by: Totoro                            *
//**************************************************

#property indicator_chart_window

extern int    Line1Space     = 10; // 1 unit = 0.01 of basic value (e.g. 1 USD cent)
extern color  Line1Color     = DeepPink;
extern int    Line1Style     = 2;
extern string LineStyleInfo  = "0=Solid,1=Dash,2=Dot,3=DashDot,4=DashDotDot";
extern int    Line2Space     = 8;
extern color  Line2Color     = LightGreen;
extern int    Line2Style     = 2;
extern int    Line3Space     = 7;
extern color  Line3Color     = LightBlue;
extern int    Line3Style     = 2;
extern string LineText      = "RoundNr ";

double Hoch;
double Tief;
bool FirstRun = true;

int deinit()
{
   double Oben    = MathRound(110*Hoch)/100;
   double Unten   = MathRound(80*Tief)/100;
 
   double AbSpace = 0.01*Line1Space;   
   for(double i=0; i<=Oben; i+=AbSpace)
   {
      if(i<Unten) continue;
      ObjectDelete(LineText+DoubleToStr(i,2));
   }
   
   AbSpace = 0.01*Line2Space;
   for(double j=0; j<=Oben; j+=AbSpace)
   {
      if(j<Unten) continue;
      ObjectDelete(LineText+DoubleToStr(j,2));
   }
   
   AbSpace = 0.01*Line3Space;
   for(double k=0; k<=Oben; k+=AbSpace)
   {
      if(k<Unten) continue;
      ObjectDelete(LineText+DoubleToStr(k,2));
   }
   
   return(0);
}

int start()
{
   if(FirstRun)
   {
      Hoch = NormalizeDouble( High[iHighest(NULL,0,MODE_HIGH,Bars-1,0)], 2 );
      Tief = NormalizeDouble( Low[iLowest(NULL,0,MODE_LOW,Bars-1,0)], 2 );
      FirstRun = false;
   }
   DrawLines();
   return(0);
}

void DrawLines()
{
   double Oben    = MathRound(110*Hoch)/100;
   double Unten   = MathRound(80*Tief)/100;

   double AbSpace = 0.01*Line1Space;
   for(double i=0; i<=Oben; i+=AbSpace)
   {
      if(i<Unten) continue;
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

   AbSpace = 0.01*Line2Space;
   for(double j=0; j<=Oben; j+=AbSpace)
   {
      if(j<Unten) continue;
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
   
   AbSpace = 0.01*Line3Space;
   for(double k=0; k<=Oben; k+=AbSpace)
   {
      if(k<Unten) continue;
      string StringNr3 = DoubleToStr(k,2);
      if (ObjectFind(LineText+StringNr3) != 0)
      {                     
         ObjectCreate(LineText+StringNr3, OBJ_HLINE, 0, 0, k);
         ObjectSet(LineText+StringNr3, OBJPROP_STYLE, Line3Style);
         ObjectSet(LineText+StringNr3, OBJPROP_COLOR, Line3Color);
      }
      else
      {
         ObjectSet(LineText+StringNr3, OBJPROP_STYLE, Line3Style);
         ObjectSet(LineText+StringNr3, OBJPROP_COLOR, Line3Color);
      }
   }

   WindowRedraw();
}