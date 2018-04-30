// class Wall2 extends Wall {

//   public void display() {
//     fill(160, 82, 45);
//     rect(x, y, sizex, sizey);
//   }

//   public void WallCheckWall() {
//     for (int i = 0; i < Walls2.size (); i ++) {

//       for (int j = 0; j < Walls2.size (); j++) {
//         if ((Walls2.get(i).x > Walls2.get(j).x) && (Walls2.get(i).x < Walls2.get(j).x2)) {
//           print("Walls realigned");
//           Walls2.remove(i);
//           Walls2.add(new Wall2());
//         }
//         if ((Walls2.get(i).x2 > Walls2.get(j).x) && (Walls2.get(i).x2 < Walls2.get(j).x2)) {
//           print("Walls realigned");
//           Walls2.remove(i);
//           Walls2.add(new Wall2());
//         }
//       }
//     }
//   }

//   void WallCheckPlayer() { 
//     for (int p = 0; p < Players.size(); p++) {
//     for (int i = 0; i < Walls.size (); i ++) {
//       if (CheckBoundaryPlayer(i,p)) {
//         if (Players.get(p).x < Walls2.get(i).x) {
//           Players.get(p).x = Players.get(p).x - Goback;
//         }
//         if (Players.get(p).x > Walls2.get(i).x2) {
//           Players.get(p).x = Players.get(p).x + Goback;
//         }
//         if ((Players.get(p).x > Walls2.get(i).x) && (Players.get(p).x < Walls2.get(i).x2)) {
//           Players.get(p).y = Players.get(p).y - Goback;
//         }
//       }
//     }
//     }
//   }

//   void WallCheckItems() {
//     for (int w = 0; w < Walls.size (); w ++) {
//       for (int k = 0; k < Items.size (); k++) {
//         if (CheckBoundaryItems(w, k)) {
//           Items.remove(k);
//           Items.add(new Item());
//         }
//       }
//     }
//   }

//   void WallCheckGuards() {
//     for (int i = 0; i < Walls.size (); i ++) {
//       for (int k = 0; k < Guards.size (); k++) {
//         if (CheckBoundaryGuard(i, k)) {

//           if (Guards.get(k).x < Walls2.get(i).x) {
//             Guards.get(k).x -= 10; 
//             Guards.get(k).Move = int(random(0, 3));
//           }
//           else if (Guards.get(k).x > Walls2.get(i).x2) {
//             Guards.get(k).x += 10; 
//             Guards.get(k).Move = int(random(0, 3));
//           }

//           else if ((Guards.get(k).x > Walls2.get(i).x) && (Guards.get(k).x < Walls2.get(i).x2)) {
//             Guards.get(k).y -= 10; 
//             Guards.get(k).Move = int(random(0, 3));
//           }
//         }
//       }
//     }
//   } 

//   private boolean CheckBoundaryGuard(int i, int k) {
//     if (((Walls2.get(i).x < Guards.get(k).x+(Guards.get(k).size/2)))&&((Walls2.get(i).x2 > Guards.get(k).x-(Guards.get(k).size/2))&&(Walls2.get(i).y + 1< Guards.get(k).y+(Guards.get(k).size/2)))) {
//       return true;
//     }
//     return false;
//   }

//   private boolean CheckBoundaryPlayer(int i, int p) {
//     if (((Walls2.get(i).x < Players.get(p).x+(Players.get(p).size/2))) && ((Walls2.get(i).x2 > Players.get(p).x-(Players.get(p).size/2)) && (Walls2.get(i).y < Players.get(p).y + (Players.get(p).size/2)))) {
//       return true;
//     }
//     return false;
//   }

//   private boolean CheckBoundaryItems(int w, int k) {
//     if (((Walls2.get(w).x < Items.get(k).x+(Items.get(k).size/2)))&&((Walls2.get(w).x2 > Items.get(k).x-(Items.get(k).size/2))&&(Walls2.get(w).y + 1< Items.get(k).y+(Items.get(k).size/2)))) {
//       return true;
//     }
//     return false;
//   }
// }