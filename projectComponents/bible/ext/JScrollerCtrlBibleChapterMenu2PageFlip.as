package projectComponents.bible.ext
{
	
	import JsC.events.JEvent;
	
	import JsF.components.scroller.act.JScrollerActBase;
	
	import projectClass.vo.o.BibleOB;
	import projectClass.vo.v.BibleVA;
	
	import projectComponents.bible.ctrl.DataBibleController;
	
	
	
	[Event(name="FINISH", type="JsC.events.JEvent")]
	
	public class JScrollerCtrlBibleChapterMenu2PageFlip extends JScrollerCtrlBibleChapterMenu1
	{
		
		public function JScrollerCtrlBibleChapterMenu2PageFlip(_ctrl:JScrollerActBase, _data:DataBibleController)
		{
			super(_ctrl, _data);
		}
		
		public function nextPage():void
		{
			setValue(+1)
		}
		
		
		public function prevPage():void
		{
			setValue(-1)
		}
		
		
		private function setValue(_number:Number):void
		{
			var _index:int = vMenu.indexOf(currentVo)
			
			if (_index + _number ==0 || _index + _number == vMenu.length)
			{
				dispatchEvent(new JEvent(JEvent.FINISH))
				return
			}else{
				_index += _number
			}
			selectIndex(_index,_number)
		}
		
		private function selectIndex(_index:uint,_number:uint=1):void
		{
			currentVo = vMenu[_index]
			if (currentVo.kind == BibleVA.kind_volume)
			{
				_index += _number
				currentVo = vMenu[_index]
			}
			if (checkAndUpdateExist())
			{
				onSelectByElementByItem(currentItem)
			}else{
				onReloadCurrentButton(true)
			}
		}
		
		
		
		public function selectVolume(_vo:BibleOB):void
		{
			scroller.stopAnimations()
			aniScrollStop()
			for (var i:int = 0; i <vMenu.length ; i++)
			{
				if(vMenu[i].sn == _vo.sn && vMenu[i].nChapter == _vo.nChapter && vMenu[i].kind == BibleVA.kind_chapter)
				{
					currentVo = vMenu[i]
					currentMenuNumber = Math.ceil(i/cTotal)*cTotal
					if (i==currentMenuNumber)
					{
						currentMenuNumber += cLength
					}
					selectIndex(i)
					break
				}
			}
		}
	}
}