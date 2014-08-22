package projectComponents.bible.ctrl
{
	import JsF.components.act.JScrollerActBase;
	import JsF.components.act.JScrollerDragPageBase;
	
	import projectClass.ctrl.BibleDB;
	
	import projectComponents.bible.model.CreateBibleModel;
	
	public class CreateBible_Base extends JScrollerDragPageBase 
	{
		protected var sql:BibleDB
		protected var currModel:CreateBibleModel
		
		
		public function CreateBible_Base(_ctrl:JScrollerActBase,_data:BibleDB)
		{
			super(_ctrl);
			sql = _data
			currModel = new CreateBibleModel
		}
		
	}
}