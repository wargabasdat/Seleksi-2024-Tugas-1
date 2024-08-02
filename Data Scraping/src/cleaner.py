from datetime import datetime
    
def categorical_to_bool(input: str):
    """
    Change column with yes/no attribute to boolean
    """
    if input == 'yes':
        return True
    else:
        return False

def parse_date_flown(date_flown_str):
    '''
    Parse the format of date flown (<Month> <Year>) to datetime
    '''
    try:
        return datetime.strptime(date_flown_str, '%B %Y').date()
    except ValueError:
        return None
    
def replace_whitespace(text: str):
    """ 
    Replace non-breaking space characters and strip leading/trailing whitespace. 
    """
    return text.replace('\xa0', ' ').strip()

def convert_airline_name(airline: str):
    return airline.replace('-',' ').title()