
public class MonsterFace extends FaceGroup
{
  public MonsterFace(String id) {
    super(id);
    
    PShape f = createShape(ELLIPSE,-30,-100,100,100); /*LM orejaIzq*/
    f.setFill(color(255, 224, 122));
    f.setStroke(color(245, 210, 93)); 
    shape.addChild(f);
    
    PShape l = createShape(ELLIPSE,100,-100,100,100);  /*LM orejaDer*/
    l.setFill(color(255, 224, 122));
    l.setStroke(color(245, 210, 93)); 
    shape.addChild(l);
    
    PShape j = createShape(ELLIPSE,-28,-100,65,70); /*LM deOrejaIzq*/
    j.setFill(color(255, 238, 178));
    j.setStroke(color(245, 210, 93)); 
    shape.addChild(j);
    
    PShape m = createShape(ELLIPSE,102,-100,65,70);  /*LM deOrejaDer*/
    m.setFill(color(255, 238, 178));
    m.setStroke(color(245, 210, 93)); 
    shape.addChild(m);
    
    PShape s = createShape(ELLIPSE,40,0,210,190);
    s.setFill(color(255, 224, 122));
    s.setStroke(color(245, 210, 93)); 
    shape.addChild(s);
    
   PShape n = createShape (TRIANGLE, 46,13,60,13,53,8);
   // PShape n = createShape(ELLIPSE,50,10,10,6); /*LM nariz*/
    n.setFill(color(61, 34, 0));
    n.setStroke(color(0)); 
    shape.addChild(n);
    
   
  }
}


public class MonsterEye extends AnimatedFeature
{
   public MonsterEye(String id, int x, int y) {
     super(id,x,y);
     open();
   }

   public PShape open() {
    shape = createShape(ELLIPSE,x,y,25,18);
    shape.setFill(color(0));
    shape.setStroke(color(0));    
    return super.open();
  } 

  public PShape close() {
    shape = createShape(LINE,x-10,y+2,x+12,y+2);
    shape.setFill(color(0));
    shape.setStrokeWeight(4);
    shape.setStroke(color(0));
    return super.close();
  }  
}

public class MonsterEyebrow extends AnimatedFeature  /*LM*/
{
  public MonsterEyebrow(String id, int x, int y) {
     super(id,x,y);
     open();
   }

  public PShape open() {                             /*LM*/
    shape = createShape(ELLIPSE,x,y-5,30,4);
    shape.setFill(color(140, 115, 32));
    shape.setStroke(color(92, 75, 18));
    return super.open();
  } 

  public PShape close() {                            /*LM*/
    shape = createShape(ELLIPSE,x,y-20,30,4);
    shape.setFill(color(140, 115, 32));
    shape.setStroke(color(92, 75, 18));
    return super.open();
  }  
}

public class MonsterMouth extends AnimatedFeature
{  
   public MonsterMouth(String id, int x, int y) {
     super(id,x,y);
     open();
   }
  
   public PShape open() {                          /*LM*/
    shape = createShape(RECT, 24, 42, 51, 18);
    shape.setFill(color(245, 103, 160));
    shape.setStroke(color(255, 130, 180));
    return super.open();
  } 

  public PShape close() {
    shape = createShape(LINE,x+25,y+50,x+75,y+50); /*LM*/
    shape.setFill(color(0));
    shape.setStrokeWeight(4);
    shape.setStroke(color(255, 130, 180));
    return super.close();
  } 
}


public class AvatarFace
{
    MonsterEye ojoIzq;
    MonsterEye ojoDer;
    MonsterEyebrow cejaIzq;  /*LM*/
    MonsterEyebrow cejaDer;  /*LM*/
    MonsterMouth boca;
    MonsterFace cara;
  
  public AvatarFace()
  {
    ojoIzq = new MonsterEye("ojoIzq",   0, 0);
    ojoDer = new MonsterEye("ojoDer", 100, 0);
    cejaIzq = new MonsterEyebrow("cejaIzq", 0, -20); /*LM*/
    cejaDer = new MonsterEyebrow("cejaDer", 100, -20); /*LM*/
    boca = new MonsterMouth("boca",   0, 0);
    cara = new MonsterFace("puppet");  
    cara.add(ojoIzq);
    cara.add(ojoDer);
    cara.add(cejaIzq); /*LM*/
    cara.add(cejaDer); /*LM*/
    cara.add(boca);
  }

  public void draw(int x, int y) {
    cara.position(x,y);
    cara.draw();
  }

  public BasicState status(FeatureID id) {
    if (id == FeatureID.LeftEye) {
        return ojoIzq.status();
    } else if (id == FeatureID.RightEye) {
        return ojoDer.status();      
    }
    return BasicState.Undefined;
  }
   
  public void change(FeatureID id, Action action)
  {
    // PS BUG no-enum-switch 
    if (id == FeatureID.LeftEye) { // ojo izq
      if (action == Action.closeEye) {
          cara.replaceShape(ojoIzq.getID(),ojoIzq.close());
      } else {
          cara.replaceShape(ojoIzq.getID(),ojoIzq.open());
      }      
    } else if (id == FeatureID.RightEye) { // ojo der
      if (action == Action.closeEye) {
          cara.replaceShape(ojoDer.getID(),ojoDer.close());
      } else {
          cara.replaceShape(ojoDer.getID(),ojoDer.open());
      } // if close
      
    } else if (id == FeatureID.LeftBrow) {         /*LM*/
      if (action == Action.closeBrow) {
          cara.replaceShape(cejaIzq.getID(),cejaIzq.close());
      } else {
          cara.replaceShape(cejaIzq.getID(),cejaIzq.open());
      } // if close  
    
    } else if (id == FeatureID.RightBrow) {         /*LM*/
      if (action == Action.closeBrow) {
          cara.replaceShape(cejaDer.getID(),cejaDer.close());
      } else {
          cara.replaceShape(cejaDer.getID(),cejaDer.open());
      } // if close 
      
    } else if (id == FeatureID.Mouth) { // boca
      if (action == Action.closeMouth) {
          cara.replaceShape(boca.getID(),boca.close());
      } else {
          cara.replaceShape(boca.getID(),boca.open());
      } // if close     
    } // else
  } // change()
} // AvatarFace class
