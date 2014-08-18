package projectComponents.bible.model
{
	import JsC.mvc.Model;
	
	import projectClass.ctrl.BibleDB;
	import projectClass.vo.o.BibleOB;
	
	public class CreateBibleModel extends Model
	{
		
		private static var _model:CreateBibleModel;
		
		
		public function CreateBibleModel()
		{
			_model = this
		}
		
		
		public static function getInstance():CreateBibleModel
		{
			if (_model == null)
			{
				_model = new CreateBibleModel();
			}
			return _model;
		}
		
		
		public function getBibleData(_data:BibleDB,_index:uint):BibleOB
		{
			var _l:BibleOB = new BibleOB
			_l.fill(_data.getBible()[_index]);
			_l.volumeName = _data.getVoumes()[_l.volume-1].short_name
			_l.contentTitle = _l.volumeName + _l.chapter + ":" + _l.verse;
			return _l;
		}
		
		public function getVolumesData(_data:BibleDB,_index:uint):BibleOB
		{
			var _l:BibleOB = new BibleOB
			_l.fill(_data.getVoumes()[_index]);
			return _l;
		}
		
	}
}