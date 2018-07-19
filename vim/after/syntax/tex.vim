" https://github.com/lervag/vimtex/issues/562
syn region texRefZone		matchgroup=texStatement start="\\v\=[Ee]qnref{"		end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\v\=[Ss]ecref{"		end="}\|%stopzone\>"	contains=@texRefGroup
syn region texRefZone		matchgroup=texStatement start="\\v\=[Ff]igref{"		end="}\|%stopzone\>"	contains=@texRefGroup
