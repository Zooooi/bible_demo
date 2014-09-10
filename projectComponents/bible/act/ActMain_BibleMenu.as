package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	
	import JsF.components.act.JScrollerActH;
	
	import projectClass.vo.o.BibleOB;
	import projectClass.vo.v.BibleVA;
	
	import projectComponents.bible.ext.JScrollerCtrlBibleChapterMenu2PageFlip;
	import projectComponents.bible.viewers.panel.BibleReader;
	import projectComponents.bible.viewers.panel.BibleSelectVolume;

	
	public class ActMain_BibleMenu extends ActMain_BibleBase
	{
		
		private var actChapter:JScrollerCtrlBibleChapterMenu2PageFlip
		protected var view:BibleReader;
		
		public function ActMain_BibleMenu(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
		}
		
		
		
		
		
		//init-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		
		public function init():void
		{
			
			//.................................................................................................
			var menuCtrl:JScrollerActH = new JScrollerActH(view.$menu);//scroller
			actChapter = new JScrollerCtrlBibleChapterMenu2PageFlip(menuCtrl,__sqlBible)
			actChapter.addEventListener(JEvent.SELECT,onChapterEvent)
			actChapter.addEventListener(JEvent.FINISH,onChapterEvent)
			actChapter._addSymbol(view.$volume)
			
			
			var _vo:BibleOB = new BibleOB
			_vo.sn = 1
			_vo.nChapter = 1
			
			__sqlBible.addEventListener(JEvent.COMPLETE,function():void{
				__sqlBible.removeEventListener(JEvent.COMPLETE,arguments.callee);
				
				__actBible.addEventListener(JEvent.ONSTART,onBibleEvent)
				__actBible.addEventListener(JEvent.ONEND,onBibleEvent)
				
				actChapter.init()
				actChapter.selectVolume(_vo)
			})
			__sqlBible.queryVO(_vo)
		}
		
		
		
		//event -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		protected function onBibleEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.ONSTART:
					actChapter.prevPage()
					break;
				
				case JEvent.ONEND:
					actChapter.nextPage()
					break;
				
				case JEvent.COMPLETE:
					break
			}
		}		
		
		
		protected function onChapterEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.SELECT:
					
					var _vo:BibleOB = BibleOB(event._data)
					
					switch(_vo.kind)
					{
						case BibleVA.kind_volume:
							
							if (view.$container.numElements != 0)
							{
								view.$container.removeAllElements()
							}
							
							var _ctrl:ActPanel_BibleSelectVolume = new ActPanel_BibleSelectVolume(new BibleSelectVolume)
							_ctrl.addEventListener(JEvent.SEND,function(event:JEvent):void{
								actChapter.selectVolume(BibleOB(event._data))
							})
							_ctrl._addEvent(event)
							_ctrl.init()
							
							view.$container.addElement(_ctrl._getView())
							
							break;
						
						case BibleVA.kind_chapter:
							__sqlBible.queryVO(_vo)
							__sqlBible.addEventListener(JEvent.COMPLETE,function():void{
								__sqlBible.removeEventListener(JEvent.COMPLETE,arguments.callee);
								__actBible.updateData()
							})
							break;
					}
					
					
					break;
				
				case JEvent.FINISH:
					__actBible.stop()
					break
			}
			
		}
		
		
		
		
	}
}