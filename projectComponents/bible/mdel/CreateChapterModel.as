package projectComponents.bible.mdel
{
	import mx.collections.ArrayList;
	
	import spark.collections.NumericDataProvider;
	
	import JsC.mvc.Model;
	
	import projectComponents.bible.vo.BibleOB;
	import projectClass.vo.v.BibleVA;
	
	public class CreateChapterModel extends Model
	{
		
		private static var aVolumeItem:ArrayList
		private static var nCurrentVolumeIndex:uint
		private static var currentVo:BibleOB
		public function CreateChapterModel()
		{
			super();
			currentVo = new BibleOB
		}
		
		/**
		 * 
		 * selectChapterPanel
		 * 
		 ******************************************************************************************************************************************************************/
		
		//1
		public function getKindArrayList(_vector:Vector.<BibleOB>):ArrayList
		{
			var aKindList:ArrayList = new ArrayList
			
			for (var j:int = 0; j < _vector.length; j++) 
			{
				var _vo:BibleOB = new BibleOB
				_vo.name = _vector[j].name
				_vo.id = _vector[j].volume
				aKindList.addItem(_vo)
			}
			return aKindList
		}
		
		//2
		public function getVoumesArrayList(_vector:Vector.<BibleOB>,_id:uint = 0):ArrayList
		{
			var vVolume:Vector.<BibleOB> = _vector
			aVolumeItem = new ArrayList
			var _b:Boolean
			
			for (var i:int = 0; i <vVolume.length ; i++)
			{
				var _vo:BibleOB = vVolume[i]
				_b = false
				switch(_id)
				{
					case 0:
						_b = true
						break
					case BibleVA.num_old:
						_b = !_vo.testament
						break;
					case BibleVA.num_new:
						_b = _vo.testament
						break
					default:
						_b = _vo.volume == _id
						break;
				}
				if (_b)
				{
					var _vo2:BibleOB = new BibleOB
					_vo2.name = _vo.full_name
					_vo2.id = i
					_vo2.sn = _vo.sn
					_vo2.chapter = _vo.chapter
					aVolumeItem.addItem(_vo2)
					if (i==0)
					{
						currentVo.sn = _vo2.sn
						currentVo.nChapter = 1
					}
				}
			}
			return aVolumeItem
		}
		
		
		
		public function getChapterArrayList_index(_index:uint = 0):NumericDataProvider{
			
			nCurrentVolumeIndex = _index
			var _num:NumericDataProvider = new NumericDataProvider
			_num.minimum = 1
			_num.maximum = aVolumeItem.getItemAt(_index).chapter
			currentVo.sn = aVolumeItem.getItemAt(_index).sn
			currentVo.nChapter = 1
			return _num	
		}
		
		
		public function getCurrentVolumeName():String
		{
			return aVolumeItem.getItemAt(nCurrentVolumeIndex).name
		}
		
		public function setChapterNumberToVo(_num:uint):void
		{
			currentVo.nChapter = _num
		}
		
		public function getCurrentVo():BibleOB
		{
			return currentVo
		}
		
		
		public function setCurrentVo(_vo:BibleOB):void
		{
			currentVo = _vo
		}
		
		/*************************************************************************************************************************************************/		
	}
}