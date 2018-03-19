import cask

from workflow import Workflow


if __name__ == '__main__':
    wf = Workflow()
    wf.cache_data('cask_all_casks', cask.get_all_casks())
    wf.cache_data('cask_installed_casks', cask.get_installed_casks())
