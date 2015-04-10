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



package tab_manager.listeners;


import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import processing.app.Editor;
import tab_manager.tool.DockTool2Base;
import tab_manager.tool.TabManager;

/**
 * 
 * @author thomas diewald (c) 2011
 *
 */
public class MyFrameListener implements WindowListener, ComponentListener{

  public MyFrameListener (){
  }
  
  @Override
  public void windowOpened(WindowEvent e) {
//    System.out.println("frame--windowOpened--"+TabManager.getName());
//    System.out.println(e);
  }

  @Override
  public void windowClosing(WindowEvent e) {
//    System.out.println("frame--windowClosed--"+TabManager.getName());
//    System.out.println(e);
    TabManager.quit();
  }

  @Override
  public void windowClosed(WindowEvent e) {
//    System.out.println("frame--windowClosed--"+TabManager.getName());
//    System.out.println(e);
    TabManager.quit();
  }

  @Override
  public void windowIconified(WindowEvent e) {
//    System.out.println("frame--windowIconified--"+TabManager.getName());
//    System.out.println(e);
  }

  @Override
  public void windowDeiconified(WindowEvent e) {
//    System.out.println("frame--windowDeiconified--"+TabManager.getName());
//    System.out.println(e);
    TabManager.getEditor().setExtendedState(Editor.NORMAL);
  }

  @Override
  public void windowActivated(WindowEvent e) {
//    System.out.println("");
//    System.out.println("frame--windowActivated--"+TabManager.getName());
//    System.out.println("e.getOppositeWindow() " + e.getOppositeWindow());
    if( e.getOppositeWindow() != TabManager.getEditor()){
      TabManager.getEditor().requestFocus();
      TabManager.getFrame().requestFocus();
    }
  }

  @Override
  public void windowDeactivated(WindowEvent e) {
//    System.out.println("");
//    System.out.println("frame--windowDeactivated--"+TabManager.getName());
//    System.out.println("e.getOppositeWindow() " + e.getOppositeWindow());
//    if( e.getOppositeWindow() == TabManager.getEditor() ){
//      TabManager.getFrame().setAlwaysOnTop(true);
//      TabManager.getEditor().requestFocus();
//    }else
//      TabManager.getFrame().setAlwaysOnTop(false);
   
  }
  
  
  @Override
  public void componentResized(ComponentEvent e) {
//    TabManager.getApplet().tryToDockOnBase();
    DockTool2Base.tryDocking();
  }

  @Override
  public void componentMoved(ComponentEvent e) {
//    System.out.println("frame--MOVED--"+TabManager.getName());
//    TabManager.getApplet().tryToDockOnBase();
    DockTool2Base.tryDocking();
  }  
  
  
  @Override
  public void componentShown(ComponentEvent e) {
//    System.out.println("editor--SHOWN--"+TabManager.getName());
    
  }

  @Override
  public void componentHidden(ComponentEvent e) {
//    System.out.println("editor--HIDDEN--"+TabManager.getName());
//    frame.hide();
  }
}
