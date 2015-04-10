/**
 * 
 * TabManager v01.20
 * 
 * TabManager is a processing tool, that lists the tabs (sketchcodes) vertically in a separate window. 
 * 
 * 
 * 
 *   (C) 2012    Thomas Diewald
 *               http://thomasdiewald.com/
 *   
 *   last built: 02/17/2012
 *   
 *   download:   http://thomasdiewald.com/processing/tools/TabManager/
 *   source:     https://github.com/diwi/ 
 *   
 *   tested OS:  osx,windows
 *   processing: 1.5.1, 2.04
 *
 *
 *
 *
 * This source is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This code is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * A copy of the GNU General Public License is available on the World
 * Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can also
 * obtain it by writing to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */


package tab_manager.tool;

import java.awt.Frame;

import processing.app.Editor;

public class DockTool2Base {
  
  private static int docking_border = 0;
  private static int dock_on_editor_y_offset_ = 0;
  private static int dock_on_editor_x_offset_ = 0;
  
  /////////////////////////////////       
  //     ____2____
  //    |         |
  //    |         |
  //  0 | editor  | 1
  //    |         |
  //    |_________|
  //         3
  /////////////////////////////////
 
  
  
  public static void reset(){
    dock_on_editor_y_offset_ = 0;
    dock_on_editor_x_offset_ = 0;
    docking_border = 0;
  }
  
  
  
  public static boolean isDocked(){
    return (docking_border >= 0);
  }
  
  private static final int MAX_GAP_ = 20;
//  
  public static void tryDocking(){
    Editor editor = TabManager.getEditor();
    Frame  frame  = TabManager.getFrame();
    
    int ex = editor.getX();
    int ey = editor.getY();
    int ew = editor.getWidth();
    int eh = editor.getHeight();
    
    
    int fx = frame.getX();
    int fy = frame.getY();
    int fw = frame.getWidth();
    int fh = frame.getHeight();
    
    if( ((fy    > ey) && (fy    < ey+eh)) ||
        ((fy+fh > ey) && (fy+fh < ey+eh))
    ){
      int dis_border_left  = Math.abs( ex-(fx+fw) );
      int dis_border_right = Math.abs( (ex+ew)-(fx) );
      
      if( dis_border_left < MAX_GAP_  || dis_border_right < MAX_GAP_  ){
        docking_border = ( dis_border_left < dis_border_right  ) ? 0 : 1;
        dock_on_editor_y_offset_ = fy-ey;
        dock();
        return;
      }
    }
    
    if( ((fx    > ex) && (fx    < ex+ew)) ||
        ((fx+fw > ey) && (fx+fw < ex+ew))
    ){
      int dis_border_top = Math.abs( ey-(fy+fh) );
      int dis_border_bot = Math.abs( (ey+eh)-(fy) );
      
      if( dis_border_top < MAX_GAP_  || dis_border_bot < MAX_GAP_  ){
        docking_border = ( dis_border_top < dis_border_bot  ) ? 2 : 3;
        dock_on_editor_x_offset_ = fx-ex;
        dock();
        return;
      }
    }
    docking_border = -1;
  }
  
//  public static void ensureDocking(){
//    Editor editor = TabManager.getEditor();
//    Frame  frame  = TabManager.getFrame();
//    
//    int ex = editor.getX();
//    int ey = editor.getY();
//    int ew = editor.getWidth();
//    int eh = editor.getHeight();
//    
//    
//    int fx = frame.getX();
//    int fy = frame.getY();
//    int fw = frame.getWidth();
//    int fh = frame.getHeight();
//    
//    if( ((fy    > ey) && (fy    < ey+eh)) ||
//        ((fy+fh > ey) && (fy+fh < ey+eh))
//    ){
//      int dis_border_left  = Math.abs( ex-(fx+fw) );
//      int dis_border_right = Math.abs( (ex+ew)-(fx) );
//      
//      if( dis_border_left < MAX_GAP_  || dis_border_right < MAX_GAP_  ){
////        docking_border = ( dis_border_left < dis_border_right  ) ? 0 : 1;
//        return;
//      }
//    }
//    
//    if( ((fx    > ex) && (fx    < ex+ew)) ||
//        ((fx+fw > ey) && (fx+fw < ex+ew))
//    ){
//      int dis_border_top = Math.abs( ey-(fy+fh) );
//      int dis_border_bot = Math.abs( (ey+eh)-(fy) );
//      
//      if( dis_border_top < MAX_GAP_  || dis_border_bot < MAX_GAP_  ){
////        docking_border = ( dis_border_top < dis_border_bot  ) ? 2 : 3;
//        return;
//      }
//    }
//    docking_border = -1;
//  }
//  
  

  public static void dock(){

    Editor editor = TabManager.getEditor();
    Frame  frame  = TabManager.getFrame();
    
    int ex = editor.getX();
    int ey = editor.getY();
    int ew = editor.getWidth();
    int eh = editor.getHeight();
    
//    int fx = frame.getX();
//    int fy = frame.getY();
    int fw = frame.getWidth();
    int fh = frame.getHeight();
    
    int x = 0, y = 0;
    if( docking_border == -1 ){
      return;
    }
    
    if( docking_border == 0 ){
      x = ex-fw;
      y = ey+dock_on_editor_y_offset_;
    }
    if( docking_border == 1 ){
      x = ex+ew;
      y = ey+dock_on_editor_y_offset_;
    }
    
    if( docking_border == 2 ){
      x = ex+dock_on_editor_x_offset_;
      y = ey-fh;
    }
    if( docking_border == 3 ){
      x = ex+dock_on_editor_x_offset_;
      y = ey+eh;
    }
    frame.setLocation(x, y);
//    ensureDocking();
  }
}
