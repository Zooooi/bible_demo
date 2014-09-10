package projectComponents.bible.ctrl
{
	import mx.core.UIComponent;
	
	import JsC.mvc.Controller;
	
	import projectClass.vo.o.BibleOB;
	import projectClass.vo.v.BibleVA;
	
	public class BibleViewCtrl extends Controller
	{
		public function BibleViewCtrl()
		{
			
		}
		
		public function setState(_ui:UIComponent,_data:BibleOB,_currentvo:BibleOB):void
		{
		/*	if (_data.volume == _currentvo.volume)
			{
				_ui.currentState = BibleVA.current_volume
			}else*/ if (!_data.testament)
			{
				_ui.currentState = BibleVA.state_old_testament
			}else{
				_ui.currentState = BibleVA.state_new_testament
			}
		}
		
		
	}
}