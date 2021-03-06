package projectComponents.bible.ext
{
	import JsF.components.scroller.act.JScrollerActBase;
	import JsF.components.scroller.ctrl.JScrollerCtrlDragAndLoadPage;
	
	import projectComponents.bible.ctrl.DataBibleController;
	
	import projectComponents.bible.mdel.CreateBibleModel;
	
	public class JScrollerCtrlBibleBase extends JScrollerCtrlDragAndLoadPage 
	{
		protected var sql:DataBibleController
		protected var currModel:CreateBibleModel
		
		
		public function JScrollerCtrlBibleBase(_ctrl:JScrollerActBase,_data:DataBibleController)
		{
			super(_ctrl);
			sql = _data
			currModel = new CreateBibleModel
		}
		
	}
}