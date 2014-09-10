package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.mvc.ActionUI;
	
	import projectComponents.bible.ctrl.DataBibleController;
	import projectComponents.bible.ctrl.DataLoader;
	
	public class ActMain_BibleBase extends ActionUI
	{
		protected static var __actBible:ActMain_BibleContent
		protected static var __actMenu:ActMain_BibleMenu
		
		protected static var __sqlProject:DataLoader
		
		protected static var __sqlBible:DataBibleController
		
		
		public function ActMain_BibleBase(_vi:UIComponent=null)
		{
			super(_vi);
		}
	}
}