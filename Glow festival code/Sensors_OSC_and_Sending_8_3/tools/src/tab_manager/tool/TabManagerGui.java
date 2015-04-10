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
import java.util.ArrayList;
import java.util.Arrays;
import diewald.p5gui.*;
import diewald.p5gui.constants.*;
import diewald.p5gui.utilities.Color;
import processing.app.Sketch;
import processing.app.SketchCode;
import processing.core.PFont;



/**
 * 
 * @author thomas diewald (c) 2011
 *
 */
public class TabManagerGui {
  private TabManagerApplet app_;
//  private Editor editor_;
  private Sketch sketch_;

  
  private GUI gui;
  
  private GUI_Button      b_UPDATE_ ;
  private GUI_Button      b_copy2clipboard_style_template_;
  private GUI_Button      b_LIBRARY_INFO_ ;
  private GUI_Switch      sw_UPDATE_auto_;
  private GUI_Button      b_add_tab_, b_new_tab_, b_rename_tab_, b_delete_tab_ ;
  private GUI_Switch      sw_tabs_[] = new GUI_Switch[0];

  private GUI_Event gui_event_;
  
  private int active_gui_tab_index_ = -1;
  private TabSetting tab_settings_[] = null;
  
  private int default_height_ = 18;
  private int default_offset_ = 20;
  private PFont gui_label_font_;

  
//------------------------------------------------------------------------------ 
  public TabManagerGui(TabManagerApplet app){
    app_ = app;
//    editor_ = app_.editor_;
    sketch_ = TabManager.getEditor().getSketch();
    makeGui();
  }
  

  
//------------------------------------------------------------------------------ 
  private void makeGui(){
    if( gui != null)
      gui.deleteGUI();
    
    gui = new GUI(app_);
    gui.autoBuild(true);
    
    gui_event_ = new TabManagerGuiEvent(app_);
    gui.setGuiEvent(gui_event_);
    
    // ----------------------------------------------------------------
    gui_label_font_ = app_.createFont("Calibri", 12);
    int x, y, w, h;
    
    x = default_offset_;
    y = default_offset_;
    w = 80;
    h = default_height_;
    
    
    x = 0;
    y = 0;
    w = h = default_height_;
    
    sw_UPDATE_auto_ = new GUI_Switch (gui, 0, "a", x, y, w, h);
    sw_UPDATE_auto_.Label().setFont(gui_label_font_);
    sw_UPDATE_auto_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    sw_UPDATE_auto_.InfoBox().setVisible(false);

    x += w;
    w = app_.width-w*3;
    b_UPDATE_ = new GUI_Button (gui, 0, "UPDATE", x, y, w, h);
    b_UPDATE_.Label().setFont(gui_label_font_);
    b_UPDATE_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_UPDATE_.InfoBox().setVisible(false);
    
    x +=w;
    w = h = default_height_;
    b_copy2clipboard_style_template_ = new GUI_Button (gui, 0, "S", x, y, w, h);
    b_copy2clipboard_style_template_.Label().setFont(gui_label_font_);
    b_copy2clipboard_style_template_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_copy2clipboard_style_template_.InfoBox().setVisible(false);
    
    x +=w;
    w = h = default_height_;
    b_LIBRARY_INFO_ = new GUI_Button (gui, 0, "i", x, y, w, h);
    b_LIBRARY_INFO_.Label().setFont(gui_label_font_);
    b_LIBRARY_INFO_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_LIBRARY_INFO_.InfoBox().setVisible(false);


     
    
    w = app_.width/2;
    h = default_height_;
    y = app_.height-h*2;
    x = 0;
    b_add_tab_ = new GUI_Button (gui, 0, "add", x, y, w, h);
    b_add_tab_.Label().setFont(gui_label_font_);
    b_add_tab_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_add_tab_.InfoBox().setVisible(false);
    
        
    x += w;
    b_new_tab_ = new GUI_Button (gui, 0, "new", x, y, app_.width/3, h);
    b_new_tab_.Label().setFont(gui_label_font_);
    b_new_tab_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_new_tab_.InfoBox().setVisible(false);
    
    
    y = app_.height-h*1;
    x = 0;
    b_rename_tab_ = new GUI_Button (gui, 0, "rename", x, y, app_.width/3, h);
    b_rename_tab_.Label().setFont(gui_label_font_);
    b_rename_tab_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_rename_tab_.InfoBox().setVisible(false);
    
    x += w;
    b_delete_tab_ = new GUI_Button (gui, 0, "delete", x, y, app_.width/3, h);
    b_delete_tab_.Label().setFont(gui_label_font_);
    b_delete_tab_.Label().setLabelAlign(LABEL_ALIGN.CENTER);
    b_delete_tab_.InfoBox().setVisible(false);
    
    defaultGuiDesign();
  }
  
  private void defaultGuiDesign(){

    ArrayList<GUI_Element> elements = gui.getElements(); 
    for(int i = 0; i < elements.size(); i++){
      GUI_Element e = elements.get(i);
      e.Border().setVisible(true);
      e.Border().setColor(ELEMENT_STATUS.DEFAULT, Color.col(50));
      e.Border().setColor(ELEMENT_STATUS.FOCUSED, Color.col(50));
      e.Border().setColor(ELEMENT_STATUS.PRESSED, Color.col(50));
      e.InfoBox().setBaseColor   (Color.col(0,150));
      e.InfoBox().setBorderColor (Color.col(50));
      e.InfoBox().setLabelColor  (Color.col(200));
      e.Base().setVisible(true);
      e.Base().setColor(ELEMENT_STATUS.DEFAULT, Color.col(0));
      e.Base().setColor(ELEMENT_STATUS.FOCUSED, Color.col(60, 77, 0));
      e.Base().setColor(ELEMENT_STATUS.PRESSED, Color.col(140, 180, 0));
    }
  }
  

  private int frame_size_x = 0;
  private int frame_size_y = 0;
  protected void updateGuiLayout(){
    
    if (frame_size_x == app_.width && 
        frame_size_y == app_.height ) return;
    
    frame_size_x = app_.width;
    frame_size_y = app_.height;
      
    int x, y, w, h;
    x = b_UPDATE_.Base().getPosX();
    w = app_.width - 
        sw_UPDATE_auto_                 .Base().getSizeX() - 
        b_copy2clipboard_style_template_.Base().getSizeX() - 
        b_LIBRARY_INFO_                 .Base().getSizeX();
    
    b_UPDATE_.Base().setSizeX(w);

    x += w;
    b_copy2clipboard_style_template_    .Base().setPosX(x);
    w = b_copy2clipboard_style_template_.Base().getSizeX();
    
    x += w;
    b_LIBRARY_INFO_.Base().setPosX(x);
    
    w = app_.width/2;
    h = default_height_;
    y = app_.height-h*2;

    b_add_tab_   .Base().setPosX(0*w);
    b_new_tab_   .Base().setPosX(1*w);
    b_rename_tab_.Base().setPosX(0*w);
    b_delete_tab_.Base().setPosX(1*w);
    
    b_add_tab_   .Base().setPosY(y);
    b_new_tab_   .Base().setPosY(y);
    b_rename_tab_.Base().setPosY(y+h);
    b_delete_tab_.Base().setPosY(y+h);
    
    b_add_tab_   .Base().setSizeX(w);
    b_new_tab_   .Base().setSizeX(w);
    b_rename_tab_.Base().setSizeX(w);
    b_delete_tab_.Base().setSizeX(w);
  }
  
  public void delete(){
    if( gui!= null )
      gui.deleteGUI();
  }
  
  protected void syncronize(){
    // check number of tabs vs. number of gui-elements
    if( tab_settings_ == null || sketch_.getCode().length != sw_tabs_.length){
      updateTabSettings(true);
      return;
    }

    // check if a tabs name has changed
    for(int i = 0; i < tab_settings_.length; i++){
      int sketch_code_index  = tab_settings_[i].sketch_code_index_;

      String sketch_code_name = sketch_.getCode(sketch_code_index).getFileName();
      String gui_tab_name = sw_tabs_[i].Label().getLabel();
      if( !gui_tab_name.equals(sketch_code_name) ){
        updateTabSettings(false);
        return;
      }
    }
    
    // check if a sketch was modified
    if( sw_UPDATE_auto_.Status().isActive() && sketch_.isModified() ){
      updateTabSettings(false);
    }
    
    checkTabStatus();
  }

  
  private void checkTabStatus(){
    SketchCode current_sketch_code = sketch_.getCurrentCode();
    if( active_gui_tab_index_ < 0 || current_sketch_code != tab_settings_[active_gui_tab_index_].sketch_code_){
      for(int i = 0; i < tab_settings_.length; i++){
        TabSetting ts = tab_settings_[i];
        if( current_sketch_code == ts.sketch_code_){
          sw_tabs_[i].Status().setActive(true);
          active_gui_tab_index_ = i;
        }else {
          sw_tabs_[i].Status().setActive(false);
        }
      }
    }
  }
  
  
  
  private void updateTabSettings(boolean rebuild_gui ){
    int label_width;
    int x, y, h;

    // extract tab settings
    tab_settings_ = TabSetting.extractTabSettings(sketch_);
    
    // sort tab settings
    Arrays.sort(tab_settings_, new TabSettingComparator());
    
    // make new tabs - usually when the number of tabs changed
    if( rebuild_gui ){
  //    System.out.println(" remove old tabs");
      ArrayList<GUI_Element> gui_elements = gui.getElements();
      for(int i = 0; i < sw_tabs_.length; i++){
        gui_elements.remove(sw_tabs_[i]);
      }
      sw_tabs_ = new GUI_Switch[tab_settings_.length];
      for(int i = 0; i < sw_tabs_.length; i++){
        sw_tabs_[i] = new GUI_Switch(gui, 2, " ", 0, 0, 1, 1);
      }
      defaultGuiDesign();
    }
    
    
    x = 20;
    y = default_offset_ + default_height_;
    h =  default_height_;

    for(int i = 0; i < sw_tabs_.length; i++){
      TabSetting ts = tab_settings_[i];
      
      int x_spec   = x + ts.tag_value_MARGIN_[0];
      int y_spec   = y + ts.tag_value_MARGIN_[1];
      
      int h_spec   = ts.tag_value_HEIGHT_ < 10 ? h : ts.tag_value_HEIGHT_;
      int col_spec = ts.tag_value_COLOR_;
      int r = (col_spec >> 16) &0xFF;
      int g = (col_spec >> 8) &0xFF;
      int b = (col_spec >> 0) &0xFF;
      sw_tabs_[i].Label().setFont(gui_label_font_);
      sw_tabs_[i].Label().setLabelAlign(LABEL_ALIGN.LEFT);
      sw_tabs_[i].Label().setLabel(tab_settings_[i].sketch_code_.getFileName());
      
      label_width = sw_tabs_[i].Label().getLabelWidth();
      sw_tabs_[i].Base().setPosXY(x_spec, y_spec);
      sw_tabs_[i].Base().setSizeY( h_spec);
      sw_tabs_[i].Base().setSizeX(label_width+8);
      sw_tabs_[i].Base().setColor(ELEMENT_STATUS.DEFAULT, Color.col(r, g, b));
      sw_tabs_[i].InfoBox().setVisible(false);
      
      // new pos
      y = y_spec+h_spec+ts.tag_value_MARGIN_[2];
    }
    active_gui_tab_index_ = -1;
    
    checkTabStatus();
    TabManager.getFrame().setMinimumSize(new Dimension(app_.size_x_min_, y+default_offset_+28 + default_height_*2));
  }
 
  
  
  
//  public void setClipboardContents( String aString ){
//    StringSelection stringSelection = new StringSelection( aString );
//    Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
//    try{
//    clipboard.setContents( stringSelection, stringSelection );
//    } catch (IllegalStateException e){
//      
//    }
//  }
  
  
  
  private class TabManagerGuiEvent extends GUI_Event{
//    TabManagerApplet app_;

    public TabManagerGuiEvent(TabManagerApplet app){
//      app_ = app;
    }
    
    public void guiEvent(GUI_Element element){
//      PApplet.println ("... active control = \"" +  element.Label().getLabel()+"\"");
      GUI_Element tabs[] = sw_tabs_;
      if( element.getID() == 2){
        for(int i = 0; i < tabs.length; i++){
          if( element == tabs[i] ){
            int idx = tab_settings_[i].sketch_code_index_;
            sketch_.setCurrentCode(idx);
            tabs[i].Status().setActive(true);
            active_gui_tab_index_ = i;
          }else{
            tabs[i].Status().setActive(false);
          }
        }
      }
      
      if( element == b_UPDATE_ ){
        updateTabSettings(false);
      }
      
      if( element == b_add_tab_){
        sketch_.handleAddFile();
      }
      if( element == b_new_tab_){
        sketch_.handleNewCode();
      }
      if( element == b_rename_tab_){
        sketch_.handleRenameCode();
      }
      if( element == b_delete_tab_){
        sketch_.handleDeleteCode();
      }
      
      if( element == sw_UPDATE_auto_ ){
        boolean active = sw_UPDATE_auto_.Status().isActive();
        if( active ){
          System.out.println("TabManager: auto-UPDATE > activated!!");
        }else {
          System.out.println("TabManager: auto-UPDATE > deactivated");
        }
      }
      
      if( element == b_copy2clipboard_style_template_ ){
//        setClipboardContents(TabSetting.STYLE_TEMPLATE_STRING_);
        System.out.println( "TabManager: style template > ");
        System.out.println( TabSetting.STYLE_TEMPLATE_STRING_);
      }
      
      if(element == b_LIBRARY_INFO_ ){
        TabManager.printToolInfo();
      }
            
    }
  } 
  

  
}
