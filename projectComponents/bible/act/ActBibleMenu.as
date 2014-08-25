package projectComponents.bible.act
{
	import mx.core.UIComponent;
	
	import JsC.events.JEvent;
	import JsC.mvc.ActionUI;
	import JsC.mvc.Model;
	
	import JsF.components.act.JScrollerActH;
	
	import projectClass.ctrl.BibleDB;
	import projectClass.ctrl.BibleDBReader;
	import projectClass.vo.o.BibleOB;
	
	import projectComponents.bible.ex.JScrollerCtrlBibleChapterMenu2PageFlip;
	import projectComponents.bible.views.panel.BibleReader;
	
	public class ActBibleMenu extends ActionUI
	{
		
		private var actBible:ActBibleContent
		private var actChapter:JScrollerCtrlBibleChapterMenu2PageFlip
		private var view:BibleReader
		private var sql:BibleDBReader
		
		public function ActBibleMenu(_vi:UIComponent=null)
		{
			super(_vi);
			view = BibleReader(_vi)
		}
		
		
		//extra symbol ----------------------------------------------------------------------------------------------------------------------------------------------------------
		
		
		override public function _addModel(_value:Model):void
		{
			// bibleDB ...................................................................................................
			if (_value is BibleDB)
			{
				sql = BibleDBReader(_value)
				init_internal_chapter()
			}
		}
		
		
		override public function _addAction(_value:ActionUI):void
		{
			if (_value is ActBibleContent)
			{
				actBible = ActBibleContent(_value)
				init_extra_bible()
			}
		}
		
		
		
		
		
		
		
		//init-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		private function init_internal_chapter():void
		{
			//.................................................................................................
			var menuCtrl:JScrollerActH = new JScrollerActH(view.$menu);//scroller
			actChapter = new JScrollerCtrlBibleChapterMenu2PageFlip(menuCtrl,sql)
			actChapter.addEventListener(JEvent.SELECT,onChapterEvent)
			actChapter.addEventListener(JEvent.FINISH,onChapterEvent)
				
			//.................................................................................................
			actChapter._addSymbol(view.$volume)
				
			//.................................................................................................
			// one first load sql
			sql.addEventListener(JEvent.COMPLETE,function():void{
				sql.removeEventListener(JEvent.COMPLETE,arguments.callee);
				actChapter.init()
				actBible.updateData()
			})
		}
		
		
		private function init_extra_bible():void
		{
			actBible.addEventListener(JEvent.ONSTART,onBibleEvent)
			actBible.addEventListener(JEvent.ONEND,onBibleEvent)
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
			}
		}		
		
		
		protected function onChapterEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.SELECT:
					//select chapter
					var _vo:BibleOB = BibleOB(event._data)
					sql.pageFlip(_vo)
					sql.addEventListener(JEvent.COMPLETE,function():void{
						sql.removeEventListener(JEvent.COMPLETE,arguments.callee);
						actBible.updateData()
					})
					break;
				
				case JEvent.FINISH:
					actBible.stop()
					break
			}
			
		}		
		
	}
}