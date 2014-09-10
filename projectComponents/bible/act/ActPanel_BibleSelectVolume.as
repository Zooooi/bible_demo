package projectComponents.bible.act
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import JsC.events.JEvent;
	
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.mdel.CreateChapterModel;
	import projectComponents.bible.viewers.panel.BibleSelectVolume;
	
	[Event(name="SEND", type="JsC.events.JEvent")]
	
	
	public class ActPanel_BibleSelectVolume extends ActMain_BibleBase
	{
		private var chapterPanel:BibleSelectVolume
		private var currentVo:BibleOB
		private var myVo:BibleOB
		private var crChapterMdel:CreateChapterModel
		
		public function ActPanel_BibleSelectVolume(_vi:UIComponent=null)
		{
			super(_vi);
			chapterPanel = BibleSelectVolume(_vi)
			chapterPanel.addEventListener(JEvent.CHANGE,onViewChangeEvent)
			chapterPanel.addEventListener(JEvent.SEND,onViewSendEvent)
				
			myVo = new BibleOB
			crChapterMdel = new CreateChapterModel
		}
		
		protected function onViewSendEvent(event:Event):void
		{
			var _event:JEvent = new JEvent(JEvent.SEND)
			_event._data = crChapterMdel.getCurrentVo()
			dispatchEvent(_event)
		}	
		
		
		override public function _addEvent(_value:JEvent):void
		{
			currentVo = BibleOB(_value._data)
		}
		
		
		public function init():void
		{
			chapterPanel.addEventListener(FlexEvent.CREATION_COMPLETE,onViewEvent)
		}
		
		
		
		protected function onViewEvent(event:FlexEvent):void
		{
			chapterPanel.$list1 = crChapterMdel.getKindArrayList(__sqlBible.getKinds())
			chapterPanel.$list2 = crChapterMdel.getVoumesArrayList(__sqlBible.getVoumes())
			chapterPanel.$list3 = crChapterMdel.getChapterArrayList_index()
				
			chapterPanel.$volumeIndex = currentVo.sn -1
			chapterPanel.$chapterIndex = currentVo.nChapter - 1
			crChapterMdel.setCurrentVo(currentVo)
			
		}
		
		
		
		protected function onViewChangeEvent(event:JEvent):void
		{
			
			switch(event.index)
			{
				case 1:
					chapterPanel.$list2 = crChapterMdel.getVoumesArrayList(__sqlBible.getVoumes(),event.id)
					chapterPanel.$list3 = crChapterMdel.getChapterArrayList_index()
					break
				
				case 2:
					chapterPanel.$list3 = crChapterMdel.getChapterArrayList_index(event.selectIndex)
					break
				
				case 3:
					crChapterMdel.setChapterNumberToVo(event.id)
					break
			}
			
				
			chapterPanel.dispatchEvent(new JEvent(JEvent.READY))
		}
	}
}