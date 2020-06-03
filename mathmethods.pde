int[] dragdifference(int mousex, int mousey, int[] coords) {
  //Takes in set of coordinates and returns the difference in coordinates divided by the camera zoom
  //(camerazoom is used to scale the drag speed depending on how zoomed in the camera is)
  int[] returncoords = new int[2];
  
  returncoords[0] = int((coords[0] - mousex) / camerazoom);
  returncoords[1] = int((coords[1] - mousey) / camerazoom);
  
  return returncoords;
}