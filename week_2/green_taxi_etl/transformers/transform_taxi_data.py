if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    
    # Question 2
    #print(f'Dataset length after filtering the dataset where the passenger count is greater than 0 and the trip distance is greater than zero: {len(data[(data.passenger_count > 0) & (data.trip_distance > 0.0)].index)}')

    # Remove zero pass. en zero distance rides. 
    data = data[~data.passenger_count.isin([0])]
    data = data[~(data.trip_distance <= 0.0)]

    # Question 3, extract date.
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    # Question 4, rename the camel case columns to snakecase. 
    camel_to_snake = {
        'VendorID': 'vendor_id',
        'RatecodeID': 'rate_code_id',
        'PULocationID': 'pu_location_id',
        'DOLocationID': 'do_location_id',
        }

    data = data.rename(columns=camel_to_snake)

    # Question 4:
    #print(f'VendorID values: {data.vendor_id.unique()}')

   
    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'vendor_id' in output.columns, 'Column with name vendor_id not present.'
    assert len(output[output.passenger_count <= 0].index) == 0, 'Zero or negative valued passenger counts.'
    assert len(output[output.trip_distance <= 0.0].index) == 0, 'Zero or negative trip distance.'