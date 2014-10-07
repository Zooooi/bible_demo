package projectComponents.bible.act.panel
{
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import JsC.events.JEvent;
	import JsC.mvc.VO;
	
	import projectComponents.bible.act.ActMain_Bible_Base;
	import projectComponents.bible.mdel.CreateChapterModel;
	import projectComponents.bible.viewers.panel.BibleSelectVolume_platform;
	import projectComponents.bible.vo.BibleOB;
	
	[Event(name="SEND", type="JsC.events.JEvent")]
	
	
	public class ActPanel_BibleSelectVolume extends ActMain_Bible_Base
	{
		private var chapterPanel:BibleSelectVolume_platform
		private var currentVo:BibleOB
		private var myVo:BibleOB
		private var crChapterMdel:CreateChapterModel
		
		public function ActPanel_BibleSelectVolume(_vi:UIComponent=null)
		{
			super(_vi);
			chapterPanel = BibleSelectVolume_platform(_vi)
			chapterPanel.addEventListener(JEvent.CHANGE,onViewChangeEvent)
			chapterPanel.addEventListener(JEvent.SEND,onViewSendEvent)
				
			myVo = new BibleOB
			crChapterMdel = new CreateChapterModel
				
			_destory_From_View(_vi,function(event:JEvent):void{
				removeEventListener(event.type,arguments.callee)
				chapterPanel = null
				currentVo = null
				myVo = null
				crChapterMdel = null
			})
		}
		
		protected function onViewSendEvent(event:Event):void
		{
			var _event:JEvent = new JEvent(JEvent.SEND)
			_event._data = crChapterMdel.getCurrentVo()
			dispatchEvent(_event)
		}	
		
		
		override public function _addVO(_value:VO):void
		{
			currentVo = BibleOB(_value)
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