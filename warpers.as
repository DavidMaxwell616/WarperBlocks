on(press){
   /TrackerSymbol:_X = _X;
   /TrackerSymbol:_Y = _Y;
   /TrackerSymbol:_xscale = _xscale;
   /TrackerSymbol:_yscale = _yscale;
   startDrag("/TrackerSymbol",0);
   /:dragged = 1;
   /:dragName = _name;
   /:dragRow = /:dragName.substr(2,1);
   /:dragCol = /:dragName.substr(3,1);
}

////////////////////////////////////////////////////////////////////////////////////

on(release, releaseOutside){
   /:dragged = 0;
   stopDrag();
}

////////////////////////////////////////////////////////////////////////////////////

on(rollOver){
   /:dragged = 2;
   /TrackerSymbol:_X = _X;
   /TrackerSymbol:_Y = _Y;
   /TrackerSymbol:_xscale = _xscale;
   /TrackerSymbol:_yscale = _yscale;
   /:dragName = _name;
   /:dragRow = /:dragName.substr(2,1);
   /:dragCol = /:dragName.substr(3,1);
}

////////////////////////////////////////////////////////////////////////////////////

on(rollOut){
   /:dragged = 0;
}

////////////////////////////////////////////////////////////////////////////////////

name = _name;
row = name.substr(2,1);
col = name.substr(3,1);
frame = int(int(row) * /:numCols + int(col) + 1);
if(frame > 1)
{
   gotoAndStop(frame);
}
else
{
   stop();
}

////////////////////////////////////////////////////////////////////////////////////

call(Track);

////////////////////////////////////////////////////////////////////////////////////

call(Track);
gotoAndPlay(_currentframe - 1);

////////////////////////////////////////////////////////////////////////////////////


if(/:dragged == 2)
{
   tellTarget("/" + /:dragName)
   {
      if(_xscale < 200)
      {
         _X = _X - 1;
         _Y = _Y - 1;
         _xscale = _xscale + 2;
         _yscale = _yscale + 2;
         /TrackerSymbol:_xscale = _xscale + 2;
         /TrackerSymbol:_yscale = _yscale + 2;
         /TrackerSymbol:_X = _X - 1;
         /TrackerSymbol:_Y = _Y - 1;
      }
   }
}
if(/:dragged >= 1)
{
   /:dragTopY = /TrackerSymbol:_Y;
   /:dragBottomY = /:dragTopY + /TrackerSymbol:_height;
   /:dragLeftX = /TrackerSymbol:_X;
   /:dragRightX = /:dragLeftX + /TrackerSymbol:_width;
   row = 0;
   /:upperDist = /:dragRow - row;
   /:lowerDist = /:numRows - /:dragRow - 1;
   while(row < /:numRows)
   {
      col = 0;
      while(col < /:numCols)
      {
         if(row < /:dragRow)
         {
            tellTarget("/T" + row + col)
            {
               scale = /:dragTopY / /:upperDist;
               if(scale > 0)
               {
                  _yscale = scale;
               }
               if(row > 0)
               {
                  _Y = scale * row;
               }
            }
         }
         else if(/:dragRow < row)
         {
            tellTarget("/T" + row + col)
            {
               scale = (/:height - /:dragBottomY) / /:lowerDist;
               dist = row - /:dragRow;
               _Y = /:dragBottomY + scale * (dist - 1);
               if(scale > 0)
               {
                  _yscale = scale;
               }
            }
         }
         else
         {
            tellTarget("/T" + row + col)
            {
               _Y = /:dragTopY;
               if(row == /:numRows - 1)
               {
                  scale = /:height - /:dragTopY;
               }
               else if(row == 0)
               {
                  _Y = 0;
                  scale = /:dragBottomY;
               }
               else
               {
                  scale = /:dragBottomY - /:dragTopY;
               }
               if(scale > 0)
               {
                  _yscale = scale;
               }
            }
         }
         col = col + 1;
      }
      row = row + 1;
   }
   col = 0;
   /:leftDist = /:dragCol - col;
   /:rightDist = /:numCols - /:dragCol - 1;
   while(col < /:numCols)
   {
      row = 0;
      while(row < /:numRows)
      {
         if(col < /:dragCol)
         {
            tellTarget("/T" + row + col)
            {
               scale = /:dragLeftX / /:leftDist;
               if(scale > 0)
               {
                  _xscale = scale;
               }
               if(col > 0)
               {
                  _X = scale * col;
               }
            }
         }
         else if(/:dragCol < col)
         {
            tellTarget("/T" + row + col)
            {
               scale = (/:width - /:dragRightX) / /:rightDist;
               dist = col - /:dragCol;
               _X = /:dragRightX + scale * (dist - 1);
               if(scale > 0)
               {
                  _xscale = scale;
               }
            }
         }
         else
         {
            tellTarget("/T" + row + col)
            {
               _X = /:dragLeftX;
               if(col == /:numCols - 1)
               {
                  scale = /:width - /:dragLeftX;
               }
               else if(col == 0)
               {
                  _X = 0;
                  scale = /:dragRightX;
               }
               else
               {
                  scale = /:dragRightX - /:dragLeftX;
               }
               if(scale > 0)
               {
                  _xscale = scale;
               }
            }
         }
         row = row + 1;
      }
      col = col + 1;
   }
}

////////////////////////////////////////////////////////////////////////////////////

height = "300";
width = "300";
numRows = "3";
numCols = "3";

////////////////////////////////////////////////////////////////////////////////////

i = 0;
while(i < /:numRows)
{
   k = 0;
   while(k < /:numCols)
   {
      tellTarget("T" + i + k + "/Border")
      {
         _visible = 0;
      }
      k = k + 1;
   }
   i = i + 1;
}
stop();