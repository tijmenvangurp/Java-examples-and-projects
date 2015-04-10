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


import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import processing.app.Sketch;
import processing.app.SketchCode;
/**
 * 
 * @author thomas diewald (c) 2011
 *
 */
public final class TabSetting {
  
  protected static final String STYLE_TEMPLATE_STRING_ = "// TabManager.config: id=1.0; margin=0, 0, 0; height=18; col=#000000;";
  
  private static final String tag_id_TOOLNAME = "TabManager";
  private static final String tag_id_TOOLJOB  = "config";

  private static final String tag_value_name_ID      = "id";
  private static final String tag_value_name_MARGIN  = "margin";
  private static final String tag_value_name_HEIGHT  = "height";
  private static final String tag_value_name_COLOR   = "col";
  
  protected float tag_value_ID_       = Float.NaN;
  protected int[] tag_value_MARGIN_   = new int[3];
  protected int   tag_value_HEIGHT_   = -1;
  protected int   tag_value_COLOR_    = 0x000000;
  protected SketchCode   sketch_code_ = null;
  protected int   sketch_code_index_  = 0;

 
  private TabSetting(){
  }
  
  protected final void printValues(){     
    System.out.println( "SKETCHCODE        = "+ sketch_code_.getFileName()  );
    System.out.println( "tag_value_ID_     = "+ tag_value_ID_    );
    System.out.println( "tag_value_MARGIN_ = "+ tag_value_MARGIN_[0] +", "+tag_value_MARGIN_[1]+", "+tag_value_MARGIN_[2] );
    System.out.println( "tag_value_HEIGHT_ = "+ tag_value_HEIGHT_);
    System.out.println( "tag_value_COLOR   = "+ tag_value_COLOR_  );
  }
  

  public final static TabSetting[] extractTabSettings(Sketch sketch){
    SketchCode sketch_codes[] = sketch.getCode();
    TabSetting[] tab_settings = new TabSetting[sketch_codes.length];

    for(int i = 0; i < sketch_codes.length; i++){
      tab_settings[i] = new TabSetting();

      tab_settings[i].sketch_code_ = sketch_codes[i];
      tab_settings[i].sketch_code_index_ = i;
      String text = sketch_codes[i].getProgram();
      
      Document d = sketch_codes[i].getDocument();
      try {
        if( d != null) 
          text = d.getText(0, d.getLength());
      } catch (BadLocationException e) {
  //      e.printStackTrace();
      }
      
      String line = text;
      int end_index = text.indexOf("\n");
      if( end_index >= 0)
        line = text.substring(0, end_index);
       
      extractFromSingleLine( tab_settings[i], line);
    }
    return tab_settings;
  }


  
  private final static void extractFromSingleLine(TabSetting tab_setting, String line){  
    if ( line != null && line.contains( tag_id_TOOLNAME )) {
      String parts_1[] = line.split(":");
      if ( parts_1 != null && parts_1.length > 1) {
        
        String tag_id     = parts_1[0];
        String tag_values = parts_1[1];
        
        tag_id = tag_id.replaceAll("/", "").trim();
        String tag_id_parts[] = tag_id.split("[.]");
 
        if ( tag_id_parts != null && 
             tag_id_parts.length == 2 &&
             tag_id_parts[0].equals( tag_id_TOOLNAME ) &&
             tag_id_parts[1].equals( tag_id_TOOLJOB  ) )
        {

          String tag_values_parts[] = tag_values.split(";");
          
          for (int i = 0; i < tag_values_parts.length; i++) {
            String value = tag_values_parts[i].trim();
            String value_parts[] = value.split("=");
            
            if ( value_parts!= null && value_parts.length == 2) {
              String tag_value_name = value_parts[0].trim();
              String tag_value      = value_parts[1].trim();
              
              if (tag_value_name.equals(tag_value_name_ID     ))  tab_setting.tag_value_ID_     = extractTagValue_ID     (tag_value);
              if (tag_value_name.equals(tag_value_name_MARGIN ))  tab_setting.tag_value_MARGIN_ = extractTagValue_MARGIN (tag_value, tab_setting.tag_value_MARGIN_);              
              if (tag_value_name.equals(tag_value_name_HEIGHT ))  tab_setting.tag_value_HEIGHT_ = extractTagValue_HEIGHT (tag_value);
              if (tag_value_name.equals(tag_value_name_COLOR  ))  tab_setting.tag_value_COLOR_  = extractTagValue_COLOR  (tag_value);
            }
          }
        }
      }
    }
  }
  
  
  private static final float extractTagValue_ID(String tag_value) {
    try{
      return Float.valueOf(tag_value);
    } catch (NumberFormatException e){
      return Float.NaN;
    }
  }

  private static final int[] extractTagValue_MARGIN(String tag_value, int margin[]) {
    String[] values_as_string = tag_value.split(",");
    
    int length = margin.length > values_as_string.length ? values_as_string.length  : margin.length;
    for(int i = 0; i < length; i++){
      try{
        margin[i] = Integer.valueOf(values_as_string[i].trim());
        if (i > 0 && margin[i] < 0) margin[i] = 0;
      } catch (NumberFormatException e){
      }
    }
    return margin;
  }

  private static final int extractTagValue_HEIGHT(String tag_value) {
    try{
      return Integer.valueOf(tag_value).intValue();
    } catch (NumberFormatException e){
      return -1;
    }
  }

  private static final int extractTagValue_COLOR(String tag_value) {
    if ( tag_value.charAt(0) != '#' || tag_value.length() != 7)
      return -2;
    tag_value = tag_value.substring(1, 7);
    try{
      return Integer.valueOf(tag_value, 16);
    } catch (NumberFormatException e){
      return -1;
    }
  }

  
}
