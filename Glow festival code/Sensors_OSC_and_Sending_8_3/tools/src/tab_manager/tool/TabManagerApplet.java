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

import java.awt.Dimension;
import java.awt.Image;
import java.awt.Toolkit;
import processing.core.PApplet;


/**
 * 
 * @author thomas diewald (c) 2011
 *
 */
@SuppressWarnings("serial")
public class TabManagerApplet extends PApplet {
  private TabManagerGui tabmanager_gui_;

  protected int size_x_min_ = 100;
  private int size_x = 200;
  private int size_y = 400;

  public TabManagerApplet(){

    byte bytes[] = loadBytes("TabManager_icon.png");
//    Image image = Toolkit.getDefaultToolkit().createImage(PApplet.ICON_IMAGE);
    Image image = Toolkit.getDefaultToolkit().createImage(bytes);
    TabManager.getFrame().setIconImage(image);
    TabManager.getFrame().setSize(new Dimension(size_x, size_y));
    TabManager.getFrame().setMinimumSize(new Dimension(size_x_min_, size_x_min_));
    
    DockTool2Base.dock();
  }
 
  public void setup(){
    size(size_x, size_y);
    background(255);
//    println("TabManagerApplet.setup()");

    tabmanager_gui_ = new TabManagerGui(this);

    tabmanager_gui_.syncronize();
    TabManager.getFrame().setSize(size_x, TabManager.getFrame().getMinimumSize().height);
    DockTool2Base.reset();
    DockTool2Base.dock();
  }
  
  public void draw(){
    background(255);
    tabmanager_gui_.syncronize();
    tabmanager_gui_.updateGuiLayout(); 
  }
  
  public void keyPressed(){
    if (key == ESC) {
      key = 0;
    }
  }

  public void keyReleased(){
    if( key=='i'){
//      boolean result = Preferences.getBoolean("editor.external");
//      System.out.println("external editor? "+result);
//      Preferences.setBoolean("editor.external", !result);
      TabManager.printToolInfo();
    }
    if (key == ESC) {
      key = 0;
    } 
  }
  
  public void deleteGUI(){
    if( tabmanager_gui_ != null)
      tabmanager_gui_.delete();
  }


}
  


  
  
  