class DatetimepickerInput < FormtasticBootstrap::Inputs::StringInput
	def input_html_options
		super
		super.merge(:class => "datetimepicker",:value=>builder.to_s)
	end
       
	def html_options
		super
		
	end
	def wrapper_html_options
		super.merge(:class=>"")
		#super.merge(:class=>"datepicker",'date-date-format'.to_sym=>"%d.%m.%Y")
	end
	def controls_wrapper_html_options
	super.merge(:class=> " date input-append", 'data-date'.to_sym =>I18n.l(Date.today()).to_s, 'data-date-format'.to_sym=>I18n.t('date.formats.default-picker'), 'data-time-format'.to_sym=>"hh:mm" ,)
	end
	def to_html
		bootstrap_wrapping do
           	builder.text_field(method, input_html_options) +
	   	'<span class="add-on" ><i class="icon-th"></i></span>'.html_safe()
	end
	end
	def options
		super
#d.merge(:class=>"datepicker")
		#super.merge(:append_content=>'<span class="add-on input-append"
		#super.merge(:append_content=>'<span class="add-on" ><i class="icon-th"></i></span>')
	end
end
