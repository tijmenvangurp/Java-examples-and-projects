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

import java.util.Comparator;
/**
 * 
 * @author thomas diewald (c) 2011
 *
 */
public class TabSettingComparator implements Comparator<TabSetting>{

  @Override
  public int compare(TabSetting o1, TabSetting o2) {
    if(  Float.isNaN(o1.tag_value_ID_ ) )
      return -1;
    if( o1.tag_value_ID_  > o2.tag_value_ID_ ) 
       return 1;
    if( o1.tag_value_ID_  < o2.tag_value_ID_)
      return -1;
    
    return 0;
  }
}