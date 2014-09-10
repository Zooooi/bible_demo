package projectComponents.bible.mdel
{
	import JsC.mvc.Model;
	
	import projectClass.vo.o.BibleOB;
	import projectClass.vo.v.BibleVA;
	
	import projectComponents.bible.ctrl.DataBibleController;
	
	public class CreateBibleModel extends Model
	{
		
		private var sTitle:String = ""
		public function CreateBibleModel()
		{
			
		}
		
		
		public function getBibleData(_data:DataBibleController,_index:uint):BibleOB
		{
			var _l:BibleOB = new BibleOB
			_l.fill(_data.getBible()[_index]);
			_l.volumeName = _data.getVoumes()[_l.volume-1].short_name
			_l.sTitle = _l.volumeName + _l.chapter + ":" + _l.verse;
			if (sTitle != "")
			{
				_l.sTitle = sTitle + "-" + _l.verse;
				sTitle = ""
			}
			if (_l.content == "")
			{
				sTitle = _l.sTitle
			}
			return _l;
		}
		
		
		public function getMenuButtonLabel(_vo:BibleOB):BibleOB
		{
			var _itemVo:BibleOB = new BibleOB
			_itemVo.testament = _vo.testament
			_itemVo.sn =  _vo.sn
			_itemVo.sTitle = _vo.full_name
			_itemVo.nChapterLength = _vo.chapter
			_itemVo.kind = BibleVA.kind_volume
			return _itemVo
		}
		public function getMenuButtonNumber(_vo:BibleOB,j:uint):BibleOB
		{
			var _itemVo:BibleOB = new BibleOB
			_itemVo.testament = _vo.testament
			_itemVo.sTitle = _vo.full_name
			_itemVo.sn =  _vo.sn
			_itemVo.volume = _vo.sn
			_itemVo.nChapter = j + 1
			_itemVo.nChapterLength = _vo.chapter
			_itemVo.kind = BibleVA.kind_chapter
			return _itemVo
		}
		
		
	}
}