package projectComponents.bible.view
{
	import mx.events.ResizeEvent;
	
	
	import projectComponents.bible.viewers.item.ChapterMenu_item_Label;
	
	public class Views_BookLable extends ChapterMenu_item_Label
	{
		override protected function onResize(event:ResizeEvent):void
		{
			nW = myText.width
		}
	}
}