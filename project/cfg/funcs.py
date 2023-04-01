from pathlib import Path
import yaml


def load_yaml(config_name: str) -> dict:
    """Reads yaml file to dict"""
    file_name = f'{config_name}.yaml'
    file_path = Path(__file__).parent.joinpath(file_name)
    with open(file_path, 'r') as stream:
        data_loaded = yaml.safe_load(stream)
    return data_loaded


if __name__ == '__main__':
    files_to_load = load_yaml('sources').get('files')
    print(files_to_load)
