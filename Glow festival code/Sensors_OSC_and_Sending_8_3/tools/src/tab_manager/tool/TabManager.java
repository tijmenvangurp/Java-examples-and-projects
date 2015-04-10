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
 
import processing.app.*;
import processing.app.tools.*;
import tab_manager.listeners.MyEditorListener;
import tab_manager.listeners.MyFrameListener;

import java.awt.*;
/**
 * 
 * @author thomas diewald (c) 2011
 *
 */
public class TabManager implements Tool {
  private static final String TOOL_AUTHOR   = "thomas diewald";
  private static final String TOOL_NAME     = "TabManager";
  private static final String TOOL_VERSION  = "v01.20";
   
  private static TabManagerApplet tab_applet_;
  private static Frame frame_;
  private static Editor editor_;
  
  private static String name_;
  
  private static boolean isOpen_ = false;
  
  static{
    System.out.println("Processing Tool: "+TOOL_NAME+" "+TOOL_VERSION);
  }
  
  public static final void printToolInfo(){
    System.out.println("");
    System.out.println("   _____________________________________________    ");
    System.out.println(" /                                               \\ ");
    System.out.println("|               TabManager 01.20                  | ");
    System.out.println("|             (c) by Thomas Diewald               | ");
    System.out.println(" \\ _____________________________________________ / ");
    System.out.println("");
  }
  
	public String getMenuTitle() {
//	  System.out.println("getMenuTitle()");
		return TOOL_NAME;
	}
	
 
	public void init(Editor editor) {
//	  System.out.println("init(Editor editor)");
	  editor_ = editor;
	}
	
	public static final TabManagerApplet getApplet(){
	  return tab_applet_;
	}
  public static final Frame getFrame(){
	  return frame_;
	}
  public static final Editor getEditor(){
    return editor_;
  }
  
  public static String getName(){
    return name_;
  }
	
  
  
	public void run() {
//	  System.out.println("run()");
	  
    if ( !isOpen_ ){
      name_   = editor_.getSketch().getName() +" - TabManager";
      frame_ = new Frame();
      tab_applet_ = new TabManagerApplet();
      
      frame_.add(tab_applet_, BorderLayout.CENTER);
      
      tab_applet_.init();
      frame_.setTitle(name_);
      
      addListeners();

      System.out.println("Tool opened: "+ name_);
      isOpen_ = true;
    }

    frame_.setExtendedState(Editor.NORMAL);
    frame_.setVisible( true );
  }
	

	
  public static void quit() {
    if( !isOpen_ )
      return;
    
    removeListeners();
    
    System.out.println("\nTool closed: "+ name_);
    
    tab_applet_.deleteGUI();
    tab_applet_.stop();
    tab_applet_ = null;

    frame_.setVisible(false); 

    frame_.dispose();
    frame_ = null;
      
    isOpen_ = false;
  }
  
  
  
  
  private static MyEditorListener editor_listener_;
  private static MyFrameListener  frame_listener_;
  
  
  private static void addListeners(){
    if( editor_listener_ != null && frame_listener_ != null)
      return;
    editor_listener_ = new MyEditorListener();
    frame_listener_  = new MyFrameListener();
    
    editor_.addWindowListener   ( editor_listener_ );
    editor_.addComponentListener( editor_listener_ );
    frame_.addWindowListener    ( frame_listener_  );
    frame_.addComponentListener ( frame_listener_  );
  }
  
  
  
  private static void removeListeners(){
    if( editor_listener_ == null && frame_listener_ == null)
      return;
    frame_.removeWindowListener    (frame_listener_ );
    frame_.removeComponentListener (frame_listener_ );
    editor_.removeWindowListener   (editor_listener_);
    editor_.removeComponentListener(editor_listener_);
    editor_listener_ = null;
    frame_listener_  = null;
  }
}




