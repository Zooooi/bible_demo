package projectComponents.bible.ext
{
	import JsF.components.act.JScrollerActBase;
	import JsF.components.act.JScrollerCtrlDragPage;
	
	import projectComponents.bible.ctrl.DataBibleController;
	
	import projectComponents.bible.mdel.CreateBibleModel;
	
	public class JScrollerCtrlBibleBase extends JScrollerCtrlDragPage 
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