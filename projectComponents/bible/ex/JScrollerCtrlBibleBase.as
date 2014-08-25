package projectComponents.bible.ex
{
	import JsF.components.act.JScrollerActBase;
	import JsF.components.act.JScrollerCtrlDragPage;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.mdel.CreateBibleModel;
	
	public class JScrollerCtrlBibleBase extends JScrollerCtrlDragPage 
	{
		protected var sql:BibleDB
		protected var currModel:CreateBibleModel
		
		
		public function JScrollerCtrlBibleBase(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl);
			sql = _data
			currModel = new CreateBibleModel
		}
		
	}
}