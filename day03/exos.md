# Slicing:
## ft_green:
auth fun.: .zeros(), .shape

green_img = np.zeros(img.shape, dtype="uint8")
green_img[:,:,1] = img[:,:,1]

# Broadcasting: 
## ft_invert_col: 
auth fun.: -

inv_img = 255 - img

## ft_red:
auth fun.: *

red_img = img * [1, 0, 0]

## ft_blue:
auth fun.: -, +, ft_red, ft_green

blue_img = img - (ft_red(img) + ft_green(img))


# Other:

## ft_cell (cellshading 1):
auth fun.: .vectorize()

def cell(pix):
	if pix < 64:
		return 64
	elif pix < 128:
		return 128
	elif pix < 192:
		return 192
	return 255

cell = np.vectorize(cell) 

** Probably could be better using an array (.arange()) to get the treshold values in cell. **


## ft_greyscale:
auth fun.: .sum(), .zeros() , .broadcast(), .reshape(), .shape

nb = np.zeros(im.shape, dtype="uint8")
tmp = ((im.sum(axis=2)/3).astype("uint8"))
shape = tmp.shape + (1,)
nb = np.broadcast_to(np.reshape(tmp, shape), im.shape)
print(nb[400,400])







